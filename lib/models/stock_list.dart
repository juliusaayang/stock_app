class StockListing {
  String ticker;
  String tickerName;
  String currency;

  StockListing({
    this.ticker,
    this.tickerName,
    this.currency
  });

  factory StockListing.fromJson(Map<String, dynamic> item){
    return StockListing(
      ticker: item['ticker'],
      tickerName: item['name'],
      currency: item['currency_name'],
    );
  }
}
