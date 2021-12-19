import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stock/constants/constants.dart';
import 'package:stock/models/api_response.dart';
import 'package:stock/models/stock_list_model.dart';
import 'package:stock/pages/stock_details.dart';
import 'package:stock/services/auth_service.dart';
import 'package:stock/services/stock_service.dart';

class Stocks extends StatefulWidget {
  @override
  _StocksState createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  StockService stockService = StockService();
  late APIResponse<List<StockListing>> _apiResponse;
  bool _isLoading = false;
  TextEditingController _controller = TextEditingController();
  ConnectivityResult _connctionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _fetchStocks();

  }



  dynamic _fetchStocks() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await stockService.getTickerData();
    setState(() {
      _isLoading = false;
    });
  }

  dynamic _fetchSearchedStocks() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await stockService.getTickerSearchData(_controller.text);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: _isLoading
            ? Container()
            : Text(
                'Stocks',
                style: GoogleFonts.raleway(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          _isLoading
              ? Container()
              : TextButton(
                  onPressed: () {
                    loginProvider.logout();
                  },
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Loading...',
                    style: kLoadingText(),
                  ),
                ],
              ),
            );
          }

          if (_apiResponse.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _apiResponse.errorMessage,
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 30,
                    width: 80,
                    child: Center(
                      child: InkResponse(
                        onTap: () => _fetchStocks(),
                        child: Text(
                          'refresh',
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  10,
                  10,
                  10,
                  10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        cursorColor: Colors.white,
                        style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.raleway(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          hintText: 'Search stocks',
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          width: 1.5,
                          color: Colors.red,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _fetchSearchedStocks();
                        },
                        icon: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(
                        10,
                        5,
                        10,
                        5,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 3,
                          bottom: 3,
                          right: 5,
                          left: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          title: Text(
                            _apiResponse.data[index].ticker,
                            style: GoogleFonts.raleway(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            _apiResponse.data[index].tickerName,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                          trailing: Text(
                            _apiResponse.data[index].currency.toUpperCase(),
                            style: GoogleFonts.raleway(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return StockDetail(
                                  ticker: _apiResponse.data[index].ticker,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) {
                    return SizedBox(
                      height: 0,
                    );
                  },
                  itemCount: _apiResponse.data.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
