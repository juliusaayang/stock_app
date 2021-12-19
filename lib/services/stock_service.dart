import 'package:http/http.dart' as http;
import 'package:stock/constants/constants.dart';
import 'dart:convert';

import 'package:stock/models/api_response.dart';
import 'package:stock/models/stock_details_model.dart';
import 'package:stock/models/stock_list_model.dart';
import 'package:stock/services/stock_service.dart';

class StockService {
  Future<APIResponse<List<StockListing>>> getTickerData() {
    return http
        .get(
      Uri.parse(kTickerEndPoint),
    )
        .then(
      (response) {
        if (response.statusCode == 200) {
          dynamic jsonData = json.decode(response.body);
          jsonData = jsonData['results'];
          final stocks = <StockListing>[];
          for (var item in jsonData) {
            StockListing.fromJson(item);
            stocks.add(
              StockListing.fromJson(item),
            );
          }
          return APIResponse<List<StockListing>>(
            data: stocks,
            error: false,
            errorMessage: 'an error occured',
          );
        }
        return APIResponse<List<StockListing>>(
          data: [],
          error: true,
          errorMessage: 'an error occured',
        );
      },
    ).catchError(
      (_) => APIResponse<List<StockListing>>(
        data: [],
        error: true,
        errorMessage: 'an error occured',
      ),
    );
  }

  Future<APIResponse<List<StockListing>>> getTickerSearchData(String searchStock) {
    
    return http
        .get(
      Uri.parse('$kTickerSearchEndPoint$searchStock&active=true&sort=ticker&order=asc&limit=20&apiKey=$apiKey'),
    )
        .then(
      (response) {
        if (response.statusCode == 200) {
          dynamic jsonData = json.decode(response.body);
          jsonData = jsonData['results'];
          final stocks = <StockListing>[];
          for (var item in jsonData) {
            StockListing.fromJson(item);
            stocks.add(
              StockListing.fromJson(item),
            );
          }
          return APIResponse<List<StockListing>>(
            data: stocks,
            error: false,
            errorMessage: 'an error occured',
          );
        }
        return APIResponse<List<StockListing>>(
          data: [],
          error: true,
          errorMessage: 'an error occured',
        );
      },
    ).catchError(
      (_) => APIResponse<List<StockListing>>(
        data: [],
        error: true,
        errorMessage: 'an error occured',
      ),
    );
  }

  Future<APIResponse<StockDetailsModel>> getStockDetails(String ticker) {
    return http
        .get(
      Uri.parse('$kTickerDetailsEndPoint$ticker?apiKey=$apiKey'),
    )
        .then(
      (response) {
        if (response.statusCode == 200) {
          dynamic jsonData = json.decode(response.body);

          return APIResponse<StockDetailsModel>(
            data: StockDetailsModel.fromJson(jsonData),
            errorMessage: '',
          );
        }
        return APIResponse<StockDetailsModel>(
          data: StockDetailsModel(),
          error: true,
          errorMessage: 'an error occured',
        );
      },
    ).catchError(
      (_) => APIResponse<StockDetailsModel>(
        data: StockDetailsModel(),
        error: true,
        errorMessage: 'an error occured',
      ),
    );
  }
}
