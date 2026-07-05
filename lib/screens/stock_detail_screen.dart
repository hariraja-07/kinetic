import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

import 'package:kinetic/models/stock.dart';

class StockDetailScreen extends StatefulWidget {
  final Stock stock;
  final ValueNotifier<Stock> notifier;
  const StockDetailScreen({
    super.key,
    required this.stock,
    required this.notifier,
  });

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  late List<FlSpot> _spots;
  bool _showCandles = false;
  int _nextX = 0;

  late double minPrice;
  late double maxPrice;

  final bidSide = OrderSide();
  final offerSide = OrderSide();

  late final Timer _orderTimer;

  @override
  void initState() {
    super.initState();

    _spots = _generateHistoricalSpots(widget.stock.price, 400);
    _nextX = _spots.length;
    widget.notifier.addListener(_onUpdate);

    minPrice = widget.stock.price;
    maxPrice = widget.stock.price;

    _orderTimer = Timer.periodic(Duration(milliseconds: 150), (_){
      bidSide.price.value = (widget.notifier.value.price-Random().nextDouble()*10).toStringAsFixed(2);
      bidSide.orders.value = Random().nextInt(500).toString();
      bidSide.qty.value = Random().nextInt(1000).toString();

      offerSide.price.value = (Random().nextDouble()*10+widget.notifier.value.price).toStringAsFixed(2);
      offerSide.orders.value = Random().nextInt(500).toString();
      offerSide.qty.value = Random().nextInt(1000).toString();
    });
  }

  void _onUpdate() {
    final newStock = widget.notifier.value;
    setState(() {
      _spots.add(FlSpot(_nextX.toDouble(), newStock.price));
      _nextX++;
      if (_spots.length > 1000) {
        _spots.removeAt(0);
      }

      if (newStock.price > maxPrice) {
        maxPrice = newStock.price;
      }

      if (newStock.price < minPrice) {
        minPrice = newStock.price;
      }
    });
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onUpdate);
    _orderTimer.cancel();
    bidSide.dispose();
    offerSide.dispose();
    super.dispose();
  }

  List<FlSpot> _generateHistoricalSpots(double endPrice, int count) {
    final random = Random();

    final List<FlSpot> spots = [];

    double price = endPrice;

    final List<double> prices = [];

    for (int i = 0; i < count; i++) {
      prices.add(price);

      price += (random.nextDouble() - 0.5) * 2.0;
      price = price.clamp(1.0, 5000.0);
    }
    final pricesRev = prices.reversed.toList();

    for (int i = 0; i < prices.length; i++) {
      spots.add(FlSpot(i.toDouble(), pricesRev[i]));
    }

    return spots;
  }

  @override
  Widget build(BuildContext context) {
    final visibleCount = 30;
    final startIndex = _spots.length > visibleCount
        ? _spots.length - visibleCount
        : 0;

    final visibleMinX = _spots[startIndex].x;
    final visibleMaxX = _spots.last.x;

    final isPositive = widget.notifier.value.change >= 0;
    final minY = _spots.map((s) => s.y).reduce((a, b) => a < b ? a : b) - 1;
    final maxY = _spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) + 1;

    final candles = _buildCandles(_spots, 10);
    final visibleCandleCount = 40;
    final candleStartIndex = candles.length > visibleCandleCount
        ? candles.length - visibleCandleCount
        : 0;

    final double visibleMinXCandle = candles.isEmpty
        ? 0
        : candles[candleStartIndex].x;
    final double visibleMaxXCandle = candles.isEmpty ? 0 : candles.last.x;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stock.symbol),
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showCandles = !_showCandles;
              });
            },
            icon: Icon(
              _showCandles ? Icons.show_chart : Icons.candlestick_chart,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.stock.name,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
          
              const SizedBox(height: 4),
          
              Row(
                children: [
                  Text(
                    widget.notifier.value.price.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isPositive ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '(${isPositive ? '+' : ''}${widget.notifier.value.change.toStringAsFixed(2)}%)',
                    style: TextStyle(
                      fontSize: 18,
                      color: isPositive ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
          
              const SizedBox(height: 20),
          
              RepaintBoundary(
                child: SizedBox(
                  height: 250,
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4.0,
                    panAxis: PanAxis.horizontal,
                    child: SizedBox(
                      height: 250,
          
                      child: _showCandles
                          ? _BuildCandlestickChart(
                              candles: candles,
                              visibileMaxX: visibleMaxXCandle,
                              visibileMinX: visibleMinXCandle,
                            )
                          : _BuildLineChart(
                              visibleMinX: visibleMinX,
                              visibleMaxX: visibleMaxX,
                              minY: minY,
                              maxY: maxY,
                              spots: _spots,
                            ),
                    ),
                  ),
                ),
              ),
          
              const SizedBox(height: 20),
          
              Text(
                'Previous Closed: ${widget.stock.price.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.blueGrey, fontSize: 16),
              ),
          
              const SizedBox(height: 20),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'low: ${minPrice.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                  ),
                  Text(
                    'high: ${maxPrice.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 30),
          
              Row(
                children: [
                  Expanded(child: _orders("Bid",bidSide)),
                  SizedBox(width: 4,),
                  Expanded(child: _orders("Offer",offerSide)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<CandlestickSpot> _buildCandles(List<FlSpot> spots, int ticks) {
  if (spots.isEmpty) return [];

  final Map<int, List<FlSpot>> buckets = {};

  for (final spot in spots) {
    final bucketKey = (spot.x ~/ ticks);
    buckets.putIfAbsent(bucketKey, () => []).add(spot);
  }

  final List<CandlestickSpot> candles = [];

  final sortedKeys = buckets.keys.toList()..sort();

  if (sortedKeys.isNotEmpty &&
      buckets[sortedKeys.first]!.length < ticks &&
      sortedKeys.length > 1) {
    sortedKeys.removeAt(0);
  }

  for (final key in sortedKeys) {
    final chunk = buckets[key]!;
    final open = chunk.first.y;
    final close = chunk.last.y;
    final high = chunk.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    final low = chunk.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    final x = chunk.first.x;
    candles.add(
      CandlestickSpot(x: x, open: open, high: high, low: low, close: close),
    );
  }

  return candles;
}

class _BuildCandlestickChart extends StatelessWidget {
  const _BuildCandlestickChart({
    required this.candles,
    required this.visibileMaxX,
    required this.visibileMinX,
  });

  final List<CandlestickSpot> candles;
  final double visibileMinX;
  final double visibileMaxX;

  @override
  Widget build(BuildContext context) {
    if (candles.isEmpty) {
      return const Center(child: Text('No Data'));
    }
    final minY = candles.map((c) => c.low).reduce((a, b) => a < b ? a : b) - 1;
    final maxY = candles.map((c) => c.high).reduce((a, b) => a > b ? a : b) + 1;

    return CandlestickChart(
      CandlestickChartData(
        minX: visibileMinX,
        maxX: visibileMaxX,
        minY: minY,
        maxY: maxY,
        candlestickSpots: candles,

        titlesData: const FlTitlesData(show: false),
        gridData: const FlGridData(show: true),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}

class _BuildLineChart extends StatelessWidget {
  const _BuildLineChart({
    required this.visibleMinX,
    required this.visibleMaxX,
    required this.minY,
    required this.maxY,
    required List<FlSpot> spots,
  }) : _spots = spots;

  final double visibleMinX;
  final double visibleMaxX;
  final double minY;
  final double maxY;
  final List<FlSpot> _spots;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: visibleMinX,
        maxX: visibleMaxX,
        minY: minY,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: _spots,
            isCurved: false,
            color: Colors.blue,
            barWidth: 2,
            belowBarData: BarAreaData(
              show: true,
              color: const Color.fromARGB(136, 33, 149, 243),
            ),
          ),
        ],

        titlesData: const FlTitlesData(show: false),
        gridData: const FlGridData(show: true),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}

class OrderSide {
  final ValueNotifier<String> price;
  final ValueNotifier<String> orders;
  final ValueNotifier<String> qty;

  OrderSide({String price = '00.00', String order = '00.00', String qty = '00'})
    : price = ValueNotifier(price),
      orders = ValueNotifier(order),
      qty = ValueNotifier(qty);

  void dispose() {
    price.dispose();
    orders.dispose();
    qty.dispose();
  }
}

//Bid Orders Qty  Offer orders qty
Widget _orders(String mode, OrderSide data) {
  final TextStyle textStyle;
  if (mode == "Bid") {
    textStyle = TextStyle(color: Colors.blue,fontSize: 12);
  } else {
    textStyle = TextStyle(color: Colors.red,fontSize: 12);
  }

  return Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    columnWidths: const {
      0: FixedColumnWidth(50),
      1: FixedColumnWidth(40),
      2: FixedColumnWidth(20),
    },

    defaultColumnWidth: const IntrinsicColumnWidth(),

    children: [
      TableRow(
        children: [
          Text(mode, style: textStyle),
          Text("Orders", style: textStyle),
          Text("Qty", style: textStyle),
        ],
      ),

      //hight
      TableRow(
        children: [
          SizedBox(height: 4),  // gap height
          SizedBox(height: 4),
          SizedBox(height: 4),
        ],
      ),

      TableRow(
        children: [
          ValueListenableBuilder(
            valueListenable: data.price,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),

          ValueListenableBuilder(
            valueListenable: data.orders,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),

          ValueListenableBuilder(
            valueListenable: data.qty,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),
        ],
      ),

      //hight
      TableRow(
        children: [
          SizedBox(height: 4),  // gap height
          SizedBox(height: 4),
          SizedBox(height: 4),
        ],
      ),
    
      TableRow(
        children: [
          ValueListenableBuilder(
            valueListenable: data.price,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),

          ValueListenableBuilder(
            valueListenable: data.orders,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),

          ValueListenableBuilder(
            valueListenable: data.qty,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),
        ],
      ),

      //hight
      TableRow(
        children: [
          SizedBox(height: 4),  // gap height
          SizedBox(height: 4),
          SizedBox(height: 4),
        ],
      ),
    
      TableRow(
        children: [
          ValueListenableBuilder(
            valueListenable: data.price,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),

          ValueListenableBuilder(
            valueListenable: data.orders,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),

          ValueListenableBuilder(
            valueListenable: data.qty,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),
        ],
      ),

      //hight
      TableRow(
        children: [
          SizedBox(height: 4),  // gap height
          SizedBox(height: 4),
          SizedBox(height: 4),
        ],
      ),

      TableRow(
        children: [
          ValueListenableBuilder(
            valueListenable: data.price,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),

          ValueListenableBuilder(
            valueListenable: data.orders,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),

          ValueListenableBuilder(
            valueListenable: data.qty,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),
        ],
      ),

      //hight
      TableRow(
        children: [
          SizedBox(height: 4),  // gap height
          SizedBox(height: 4),
          SizedBox(height: 4),
        ],
      ),

      TableRow(
        children: [
          ValueListenableBuilder(
            valueListenable: data.price,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),

          ValueListenableBuilder(
            valueListenable: data.orders,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),

          ValueListenableBuilder(
            valueListenable: data.qty,
            builder: (_, value, __) => Text(value, style: textStyle),
          ),
        ],
      ),
    
    ],
  );
}
