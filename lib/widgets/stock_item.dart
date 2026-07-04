import 'package:flutter/material.dart';

class StockItem extends StatelessWidget {
  const StockItem({
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
