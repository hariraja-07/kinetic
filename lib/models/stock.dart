class Stock {
  final String symbol;
  final String name;
  final double price;
  final double change;

  const Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
  });

  Stock copyWith({String? symbol,String? name,double? price,double? change}){
    return Stock(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      price: price ?? this.price,
      change: change ?? this.change,
    );
  }
}