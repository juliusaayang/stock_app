class StockListing {
  String ticker;
  String tickerName;
  String currency;

  StockListing({
    required this.ticker,
    required this.tickerName,
    required this.currency
  });

  factory StockListing.fromJson(Map<String, dynamic> item){
    return StockListing(
      ticker: item['ticker'],
      tickerName: item['name'],
      currency: item['currency_name'],
    );
  }
}
