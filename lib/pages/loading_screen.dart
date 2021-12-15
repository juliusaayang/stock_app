import 'package:flutter/material.dart';
import 'package:stock/pages/stock_list.dart';
import 'package:stock/services/stock_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    var tickerData = await StockService().getTickerData();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Stocks(
            stockData: tickerData,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
