import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

import 'package:kinetic/models/stock.dart';

class StockDetailScreen extends StatefulWidget{

  final Stock stock;
  final ValueNotifier<Stock> notifier;
  const StockDetailScreen({super.key,required this.stock,required this.notifier});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  late List<FlSpot> _spots;

  @override  
  void initState(){
    super.initState();

    _spots = _generateHistoricalSpots(widget.stock.price,30);

    widget.notifier.addListener(_onUpdate);
  }

  void _onUpdate(){
    final newStock = widget.notifier.value;
    setState(() {
      _spots.add(FlSpot(_spots.length.toDouble(), newStock.price));

      if(_spots.length>1000){
        _spots.removeAt(0);
      }
    });
  }

  @override 
  void dispose(){
    widget.notifier.removeListener(_onUpdate);
    super.dispose();
  }

  List<FlSpot> _generateHistoricalSpots(double endPrice, int count){
    final random = Random();

    final List<FlSpot> spots = [];

    double price = endPrice;

    final List<double> prices = [];

    for(int i=0;i<count;i++){
      prices.add(price);

      price += (random.nextDouble()-0.5)*2.0;
      price = price.clamp(1.0, 5000.0);
    }
    final pricesRev = prices.reversed.toList();

    for(int i=0;i<prices.length;i++){
      spots.add(FlSpot(i.toDouble(), pricesRev[i]));
    }

    return spots;
  }

  @override  
  Widget build(BuildContext context){
    final visibleCount = 30;
    final startIndex = _spots.length > visibleCount? _spots.length - visibleCount : 0;

    final visibleMinX = _spots[startIndex].x;
    final visibleMaxX = _spots.last.x;

    final isPositive = widget.notifier.value.change >=0;
    final minY = _spots.map((s)=> s.y).reduce((a,b) => a<b ? a : b)-1;
    final maxY = _spots.map((s)=> s.y).reduce((a,b) => a>b ? a : b)+1;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stock.symbol),
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.stock.name,
              style: const TextStyle(fontSize: 18, color:  Colors.grey),
            ),

            const SizedBox(height: 4,),

            Row(
              children: [
                Text(
                  widget.notifier.value.price.toStringAsFixed(2),
                  style: const TextStyle(fontSize: 34,fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16,),
                Text(
                  '(${isPositive?'+':''}${widget.notifier.value.change.toStringAsFixed(2)}%)',
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red
                  ),
                )
              ],
            ),

            const SizedBox(height: 20,),

            RepaintBoundary(
              child: SizedBox(
                height: 250,
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  panAxis: PanAxis.horizontal,
                  child: SizedBox(
                    width: 1000,
                    height: 250,

                    child: LineChart(
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
                              color:  const Color.fromARGB(136, 33, 149, 243)
                            )
                          )
                        ],
                    
                        titlesData: const FlTitlesData(show: false),
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false)
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}