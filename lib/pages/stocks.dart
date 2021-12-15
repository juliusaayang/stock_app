import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock/models/api_response.dart';
import 'package:stock/models/stock_list.dart';
import 'package:stock/services/stock_service.dart';

class Stocks extends StatefulWidget {
  const Stocks({Key key}) : super(key: key);

  @override
  _StocksState createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  StockService get service => GetIt.I<StockService>();

  APIResponse<List<StockListing>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchStocks();
    super.initState();
  }

  _fetchStocks() async {
    setState(
      () => _isLoading = true,
    );

    _apiResponse = await service.getTickerData();

    setState(
      () => _isLoading = false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_apiResponse.error) {
            return Center(
              child: Text(_apiResponse.errorMessage),
            );
          }

          return ListView.separated(
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  _apiResponse.data[index].tickerName,
                ),
                subtitle: Text(
                  _apiResponse.data[index].ticker,
                ),
                leading: Text(
                  _apiResponse.data[index].currency,
                ),
              );
            },
            separatorBuilder: (_, __) {
              return Divider(
                height: 1,
                color: Colors.blue,
              );
            },
            itemCount: _apiResponse.data.length,
          );
        },
      ),
    );
  }
}
