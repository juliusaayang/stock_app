import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock/models/api_response.dart';
import 'package:stock/models/stock_list.dart';

class StockService {
  final String kTickerEndPoint =
      'https://api.polygon.io/v3/reference/tickers?market=stocks&active=true&sort=ticker&order=asc&limit=10&apiKey=eOCFJBzA6Pykt62Zq5MFBGXKIIIho4nS';
  static const headers = {
    'apiKey': 'eOCFJBzA6Pykt62Zq5MFBGXKIIIho4nS',
    'Content-Type': 'application/json',
  };

  Future<APIResponse<List<StockListing>>> getTickerData(){
    return http
        .get(
      Uri.parse(kTickerEndPoint),
    )
        .then(
      (data) {
        if (data.statusCode == 200) {
          final jsonData = jsonDecode(data.body);
          final stocks = <StockListing>[];
          for (var item in jsonData) {
            StockListing.fromJson(item);
            stocks.add(
              StockListing.fromJson(item),
            );
          }
          return APIResponse<List<StockListing>>(
            data: stocks,
          );
        }
        return APIResponse<List<StockListing>>(
          error: true,
          errorMessage: 'an error occured',
        );
      },
    ).catchError(
      (_) => APIResponse<List<StockListing>>(
        error: true,
        errorMessage: 'an error occured',
      ),
    );
  }
}
