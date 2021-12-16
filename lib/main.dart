import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'pages/loading_screen.dart';
import 'services/stock_service.dart';

void main() {
  runApp(
    MaterialApp(
      home: LoadingScreen(),
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Color(0xFF0A0E21),
        ),
      ),
    ),
  );
}
