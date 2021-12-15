import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock/models/api_response.dart';
import 'package:stock/models/stock_list.dart';
import 'package:stock/services/networking.dart';

const apiKey = 'eOCFJBzA6Pykt62Zq5MFBGXKIIIho4nS';
const kTickerEndPoint =
    'https://api.polygon.io/v3/reference/tickers?market=stocks&active=true&sort=ticker&order=asc&limit=10&apiKey=$apiKey';

class StockService {
  Future<dynamic> getTickerData() async {
    NetworkHelper networkHelper = NetworkHelper(kTickerEndPoint);

    var tickerData = await networkHelper.getStockData();
    return tickerData;
  }
}
