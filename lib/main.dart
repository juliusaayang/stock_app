import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stock/pages/stocks.dart';

import 'services/stock_service.dart';

void setUpLocator() {
  GetIt.I.registerLazySingleton(
    () => StockService(),
  );
}

void main() {
  setUpLocator();
  runApp(
    MaterialApp(
      home: Stocks(),
    ),
  );
}
