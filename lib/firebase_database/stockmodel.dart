class Stock {
  double open;
  String symbol;
  String trend;
  double percent;

  Stock(double open, String symbol, String trend, double percent) {
    this.open = open;
    this.symbol = symbol;
    this.trend = trend;
    this.percent = percent;
  }

  Stock.fromJson(Map json)
      : symbol = json['symbol'],
        open = json['open'],
        trend = json['trend'],
        percent = json['percent'];

  Map toJson() {
    return {'symbol': symbol, 'open': open, 'trend': trend, 'percent': percent};
  }
}
