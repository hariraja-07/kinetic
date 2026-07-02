import 'package:flutter/material.dart';

void main(){
  runApp(App());
}

class App extends StatelessWidget{
  const App({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: true,
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget{
  Home({super.key});

  final stocks = [
    {"symbol": "RELIANCE", "name": "Reliance Industries", "price": 2850.0, "change": 12.3},
    {"symbol": "TCS", "name": "Tata Consultancy Services", "price": 3850.0, "change": -5.4},
    {"symbol": "HDFCBANK", "name": "HDFC Bank", "price": 1650.0, "change": -2.1},
    {"symbol": "ICICIBANK", "name": "ICICI Bank", "price": 1120.0, "change": 4.5},
    {"symbol": "INFY", "name": "Infosys", "price": 1520.0, "change": 8.2},
    {"symbol": "HINDUNILVR", "name": "Hindustan Unilever", "price": 2480.0, "change": 2.3},
    {"symbol": "ITC", "name": "ITC", "price": 450.0, "change": 1.5},
    {"symbol": "KOTAKBANK", "name": "Kotak Mahindra Bank", "price": 1780.0, "change": -0.9},
    {"symbol": "LT", "name": "Larsen & Toubro", "price": 3250.0, "change": 6.7},
    {"symbol": "SBIN", "name": "State Bank of India", "price": 780.0, "change": 3.2},
    {"symbol": "BHARTIARTL", "name": "Bharti Airtel", "price": 920.0, "change": -1.8},
    {"symbol": "BAJFINANCE", "name": "Bajaj Finance", "price": 6850.0, "change": 7.8},
    {"symbol": "SUNPHARMA", "name": "Sun Pharmaceutical", "price": 1680.0, "change": -3.5},
    {"symbol": "TATAMOTORS", "name": "Tata Motors", "price": 980.0, "change": 5.1},
    {"symbol": "ADANIPORTS", "name": "Adani Ports", "price": 1420.0, "change": -1.5},
    {"symbol": "MARUTI", "name": "Maruti Suzuki", "price": 11800.0, "change": -3.2},
    {"symbol": "ASIANPAINT", "name": "Asian Paints", "price": 3280.0, "change": 1.9},
    {"symbol": "NESTLEIND", "name": "Nestle India", "price": 2180.0, "change": -0.5},
    {"symbol": "HCLTECH", "name": "HCL Technologies", "price": 1280.0, "change": 3.8},
    {"symbol": "WIPRO", "name": "Wipro", "price": 420.0, "change": 1.2},
    {"symbol": "TITAN", "name": "Titan Company", "price": 3680.0, "change": 5.6},
    {"symbol": "ULTRACEMCO", "name": "UltraTech Cement", "price": 11200.0, "change": -2.3},
    {"symbol": "POWERGRID", "name": "Power Grid Corporation", "price": 320.0, "change": -1.2},
    {"symbol": "ONGC", "name": "Oil & Natural Gas Corp", "price": 260.0, "change": -0.8},
    {"symbol": "NTPC", "name": "NTPC", "price": 380.0, "change": 2.1},
    {"symbol": "COALINDIA", "name": "Coal India", "price": 490.0, "change": 3.4},
    {"symbol": "JSWSTEEL", "name": "JSW Steel", "price": 890.0, "change": -2.8},
    {"symbol": "TATASTEEL", "name": "Tata Steel", "price": 165.0, "change": 4.2},
    {"symbol": "HDFCLIFE", "name": "HDFC Life Insurance", "price": 720.0, "change": -0.7},
    {"symbol": "SBILIFE", "name": "SBI Life Insurance", "price": 1680.0, "change": 2.9},
    {"symbol": "CIPLA", "name": "Cipla", "price": 1420.0, "change": 2.1},
    {"symbol": "DRREDDY", "name": "Dr. Reddy's Laboratories", "price": 6980.0, "change": -3.4},
    {"symbol": "TECHM", "name": "Tech Mahindra", "price": 1680.0, "change": -1.9},
    {"symbol": "BAJAJFINSV", "name": "Bajaj Finserv", "price": 1680.0, "change": -4.1},
    {"symbol": "ADANIENT", "name": "Adani Enterprises", "price": 3280.0, "change": 6.2},
    {"symbol": "GRASIM", "name": "Grasim Industries", "price": 2180.0, "change": 1.8},
    {"symbol": "HEROMOTOCO", "name": "Hero MotoCorp", "price": 4450.0, "change": 2.6},
    {"symbol": "DIVISLAB", "name": "Divi's Laboratories", "price": 4850.0, "change": 4.5},
    {"symbol": "APOLLOHOSP", "name": "Apollo Hospitals", "price": 6280.0, "change": -1.8},
    {"symbol": "BPCL", "name": "Bharat Petroleum", "price": 620.0, "change": 3.1},
    {"symbol": "EICHERMOT", "name": "Eicher Motors", "price": 4280.0, "change": -2.5},
    {"symbol": "IOC", "name": "Indian Oil Corporation", "price": 160.0, "change": 1.4},
    {"symbol": "INDUSINDBK", "name": "IndusInd Bank", "price": 1580.0, "change": -3.2},
    {"symbol": "AXISBANK", "name": "Axis Bank", "price": 1080.0, "change": 2.8},
    {"symbol": "PNB", "name": "Punjab National Bank", "price": 125.0, "change": -1.6},
    {"symbol": "BANKBARODA", "name": "Bank of Baroda", "price": 280.0, "change": 3.5},
    {"symbol": "CANBK", "name": "Canara Bank", "price": 520.0, "change": -2.1},
    {"symbol": "M&M", "name": "Mahindra & Mahindra", "price": 1680.0, "change": 4.8},
    {"symbol": "TRENT", "name": "Trent", "price": 4280.0, "change": -1.9},
    {"symbol": "DMART", "name": "Avenue Supermarts", "price": 4280.0, "change": -1.1},
  ];
    
  @override   
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Kinetic"),
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          final stock = stocks[index];
          final isPositive = (stock["change"] as num) >= 0;
          final price = (stock["price"] as num);
          final change = (stock["change"] as num);

          return ListTile(
            leading: CircleAvatar(
              child: Text(
                (stock["symbol"] as String)[0]
              ),
            ),

            title: Text(
              stock["symbol"] as String 
            ),

            subtitle: Text(
              stock["name"] as String
            ),

            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price.toStringAsFixed(2),
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontSize: 14
                  ),
                ),
                Text(
                  "(${isPositive?'+':''}${change.toStringAsFixed(2)}%)",
                  style: TextStyle(
                    color:  isPositive? Colors.green : Colors.red,
                    fontSize: 13
                  ),
                )
              ],
            ),
          );
        },
      )
    );
  }
}