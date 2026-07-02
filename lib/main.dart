import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  static const List<Stock> stocks = [
    Stock(symbol: "RELIANCE", name: "Reliance Industries", price: 2850.0, change: 12.3),
    Stock(symbol: "TCS", name: "Tata Consultancy Services", price: 3850.0, change: -5.4),
    Stock(symbol: "HDFCBANK", name: "HDFC Bank", price: 1650.0, change: -2.1),
    Stock(symbol: "ICICIBANK", name: "ICICI Bank", price: 1120.0, change: 4.5),
    Stock(symbol: "INFY", name: "Infosys", price: 1520.0, change: 8.2),
    Stock(symbol: "HINDUNILVR", name: "Hindustan Unilever", price: 2480.0, change: 2.3),
    Stock(symbol: "ITC", name: "ITC", price: 450.0, change: 1.5),
    Stock(symbol: "KOTAKBANK", name: "Kotak Mahindra Bank", price: 1780.0, change: -0.9),
    Stock(symbol: "LT", name: "Larsen & Toubro", price: 3250.0, change: 6.7),
    Stock(symbol: "SBIN", name: "State Bank of India", price: 780.0, change: 3.2),
    Stock(symbol: "BHARTIARTL", name: "Bharti Airtel", price: 920.0, change: -1.8),
    Stock(symbol: "BAJFINANCE", name: "Bajaj Finance", price: 6850.0, change: 7.8),
    Stock(symbol: "SUNPHARMA", name: "Sun Pharmaceutical", price: 1680.0, change: -3.5),
    Stock(symbol: "TATAMOTORS", name: "Tata Motors", price: 980.0, change: 5.1),
    Stock(symbol: "ADANIPORTS", name: "Adani Ports", price: 1420.0, change: -1.5),
    Stock(symbol: "MARUTI", name: "Maruti Suzuki", price: 11800.0, change: -3.2),
    Stock(symbol: "ASIANPAINT", name: "Asian Paints", price: 3280.0, change: 1.9),
    Stock(symbol: "NESTLEIND", name: "Nestle India", price: 2180.0, change: -0.5),
    Stock(symbol: "HCLTECH", name: "HCL Technologies", price: 1280.0, change: 3.8),
    Stock(symbol: "WIPRO", name: "Wipro", price: 420.0, change: 1.2),
    Stock(symbol: "TITAN", name: "Titan Company", price: 3680.0, change: 5.6),
    Stock(symbol: "ULTRACEMCO", name: "UltraTech Cement", price: 11200.0, change: -2.3),
    Stock(symbol: "POWERGRID", name: "Power Grid Corporation", price: 320.0, change: -1.2),
    Stock(symbol: "ONGC", name: "Oil & Natural Gas Corp", price: 260.0, change: -0.8),
    Stock(symbol: "NTPC", name: "NTPC", price: 380.0, change: 2.1),
    Stock(symbol: "COALINDIA", name: "Coal India", price: 490.0, change: 3.4),
    Stock(symbol: "JSWSTEEL", name: "JSW Steel", price: 890.0, change: -2.8),
    Stock(symbol: "TATASTEEL", name: "Tata Steel", price: 165.0, change: 4.2),
    Stock(symbol: "HDFCLIFE", name: "HDFC Life Insurance", price: 720.0, change: -0.7),
    Stock(symbol: "SBILIFE", name: "SBI Life Insurance", price: 1680.0, change: 2.9),
    Stock(symbol: "CIPLA", name: "Cipla", price: 1420.0, change: 2.1),
    Stock(symbol: "DRREDDY", name: "Dr. Reddy's Laboratories", price: 6980.0, change: -3.4),
    Stock(symbol: "TECHM", name: "Tech Mahindra", price: 1680.0, change: -1.9),
    Stock(symbol: "BAJAJFINSV", name: "Bajaj Finserv", price: 1680.0, change: -4.1),
    Stock(symbol: "ADANIENT", name: "Adani Enterprises", price: 3280.0, change: 6.2),
    Stock(symbol: "GRASIM", name: "Grasim Industries", price: 2180.0, change: 1.8),
    Stock(symbol: "HEROMOTOCO", name: "Hero MotoCorp", price: 4450.0, change: 2.6),
    Stock(symbol: "DIVISLAB", name: "Divi's Laboratories", price: 4850.0, change: 4.5),
    Stock(symbol: "APOLLOHOSP", name: "Apollo Hospitals", price: 6280.0, change: -1.8),
    Stock(symbol: "BPCL", name: "Bharat Petroleum", price: 620.0, change: 3.1),
    Stock(symbol: "EICHERMOT", name: "Eicher Motors", price: 4280.0, change: -2.5),
    Stock(symbol: "IOC", name: "Indian Oil Corporation", price: 160.0, change: 1.4),
    Stock(symbol: "INDUSINDBK", name: "IndusInd Bank", price: 1580.0, change: -3.2),
    Stock(symbol: "AXISBANK", name: "Axis Bank", price: 1080.0, change: 2.8),
    Stock(symbol: "PNB", name: "Punjab National Bank", price: 125.0, change: -1.6),
    Stock(symbol: "BANKBARODA", name: "Bank of Baroda", price: 280.0, change: 3.5),
    Stock(symbol: "CANBK", name: "Canara Bank", price: 520.0, change: -2.1),
    Stock(symbol: "M&M", name: "Mahindra & Mahindra", price: 1680.0, change: 4.8),
    Stock(symbol: "TRENT", name: "Trent", price: 4280.0, change: -1.9),
    Stock(symbol: "DMART", name: "Avenue Supermarts", price: 4280.0, change: -1.1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kinetic"),
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemExtent: 74.0,
        addAutomaticKeepAlives: false,
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          final stock = stocks[index];
          return _StockItem(
            key: ValueKey(stock.symbol),
            symbol: stock.symbol,
            name: stock.name,
            price: stock.price,
            change: stock.change,
          );
        },
      ),
    );
  }
}

class Stock {
  final String symbol;
  final String name;
  final double price;
  final double change;

  const Stock({
    required this.symbol,
    required this.name,
    required this.price, 
    required this.change
  });
}

class _StockItem extends StatelessWidget {
  const _StockItem({
    super.key,
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
  });

  final String symbol;
  final String name;
  final double price;
  final double change;

  static const priceGreen = TextStyle(color: Colors.green);
  static const priceRed = TextStyle(color: Colors.red);
  static const changeColor = TextStyle(color: Colors.grey);
  static const symbolStyle = TextStyle(fontWeight: FontWeight.bold);
  static const nameStyle = TextStyle(fontSize: 12, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    final isPositive = change >= 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
    
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(symbol, style: symbolStyle),
                Text(name, style: nameStyle),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                price.toStringAsFixed(2),
                style: isPositive ? priceGreen : priceRed,
              ),
              Text(
                '(${isPositive ? '+' : ''}${change.toStringAsFixed(2)}%)',
                style: changeColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
