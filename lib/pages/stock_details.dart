import 'package:flutter/material.dart';
import 'package:stock/services/stock_service.dart';

class StockDetail extends StatefulWidget {
  StockDetail({this.ticker});
  final String ticker;

  @override
  _StockDetailState createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail> {
  StockService stocks = StockService();
  String ticker;
  String tickerName;
  String currencyName;
  String market;
  bool _isLoading;

  @override
  void initState() {
    getData(widget.ticker);
    super.initState();
  }

  void getData(dynamic tickerDetails) async {
    setState(() {
      _isLoading = true;
    });
    var tickerDetails = await StockService().getTickerDetails(widget.ticker);
    setState(() {
      _isLoading = false;
    });
    setState(() {
      if (tickerDetails == null) {
        ticker = 'No value';
        tickerName = 'No value';
        currencyName = 'USD';
        market = 'Stock';

        return;
      }
      var tick = tickerDetails['results']['ticker'];
      ticker = tick;

      var name = tickerDetails['results']['name'];
      tickerName = name;

      var currency = tickerDetails['results']['currency_name'];
      currencyName = currency;

      market = tickerDetails['results']['market'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        if (_isLoading) {
          return Scaffold(
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Loading...',
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: tickerName == null ? Text('') : Text(tickerName),
          ),
          body: Column(
            children: [
              Text(market),
              Text(currencyName),
            ],
          ),
        );
      },
    );
  }
}
