import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'pages/loading_screen.dart';
import 'services/stock_service.dart';


void main() {
  runApp(
    MaterialApp(
      home: LoadingScreen(),
    ),
  );
}
