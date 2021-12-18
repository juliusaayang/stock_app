class StockDetailsModel {
  var ticker;
  var tickerName;
  var currencyName;
  var market;
  var marketCap;
  var primaryExchange;
  var locale;
  var outstandingShares;
  var address;
  var city;
  var state;
  var postalCode;
  var phone;
  

  StockDetailsModel({
    this.ticker,
    this.tickerName,
    this.currencyName,
    this.market,
    this.marketCap,
    this.primaryExchange,
    this.locale,
    this.outstandingShares,
    this.address,
    this.city,
    this.postalCode,
    this.state,
    this.phone,
    
  });

  factory StockDetailsModel.fromJson(Map<String, dynamic> item) {
    return StockDetailsModel(
      ticker: item['results'],
      tickerName: item['results'],
      currencyName: item['results'],
      market: item['results'],
      marketCap: item['results'],
      primaryExchange: item['results'],
      locale: item['results'],
      outstandingShares: item['results'],
      address: item['results']['address'],
      city: item['results']['address'],
      postalCode: item['results']['address'],
      state: item['results']['address'],
      phone: item['results'],
      
    );
  }
}
