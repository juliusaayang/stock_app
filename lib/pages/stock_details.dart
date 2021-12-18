import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock/constants/constants.dart';
import 'package:stock/models/api_response.dart';
import 'package:stock/models/stock_details_model.dart';
import 'package:stock/services/stock_service.dart';
import 'package:stock/widgets/detail_row.dart';

class StockDetail extends StatefulWidget {
  StockDetail({this.ticker});
  final String? ticker;

  @override
  _StockDetailState createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail> {
  StockService networkHelper = StockService();
  APIResponse<StockDetailsModel>? _apiResponse;
  var address;
  var city;
  var state;
  var postalCode;
  var phone;
  var locale;
  var primaryExchange;
  var marketCap;
  var market;
  var outstandingShares;
  var currencyName;
  var tickerName;
  var ticker;

  bool _isLoading = false;

  @override
  void initState() {
    _fetchTickerDetails(widget.ticker);

    super.initState();
  }

  dynamic _fetchTickerDetails(dynamic tickerDetails) async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await StockService().getStockDetails(tickerDetails);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ticker = _apiResponse?.data.ticker == null
        ? ''
        : _apiResponse?.data.ticker['ticker'];
    tickerName = _apiResponse?.data.tickerName == null
        ? ''
        : _apiResponse?.data.tickerName['name'];
    currencyName = _apiResponse?.data.currencyName == null
        ? ''
        : _apiResponse?.data.ticker['currency_name'];
    market = _apiResponse?.data.market == null
        ? ''
        : _apiResponse?.data.market['market'];
    marketCap = _apiResponse?.data.marketCap == null
        ? ''
        : _apiResponse?.data.marketCap['market_cap'];
    primaryExchange = _apiResponse?.data.primaryExchange == null
        ? ''
        : _apiResponse?.data.primaryExchange['primary_exchange'];
    locale = _apiResponse?.data.locale == null
        ? ''
        : _apiResponse?.data.locale['locale'];
    phone = _apiResponse?.data.phone == null
        ? ''
        : _apiResponse?.data.phone['phone_number'];

    outstandingShares = _apiResponse?.data.outstandingShares == null
        ? ''
        : _apiResponse?.data.outstandingShares['outstanding_shares'];
    address = _apiResponse?.data.address == null
        ? ''
        : _apiResponse?.data.address['address1'];
    city =
        _apiResponse?.data.city == null ? '' : _apiResponse?.data.city['city'];
    state = _apiResponse?.data.state == null
        ? ''
        : _apiResponse?.data.state['state'];
    postalCode = _apiResponse?.data.postalCode == null
        ? ''
        : _apiResponse?.data.postalCode['postal_code'];
    return Builder(
      builder: (_) {
        if (_isLoading) {
          return Scaffold(
            body: Center(
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
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: ticker == null
                ? Container()
                : Text(
                    ticker,
                  ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    10,
                    20,
                    10,
                    50,
                  ),
                  child: Center(
                    child: Text(
                      tickerName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                currencyName == null
                    ? Container()
                    : DetailRow(
                        attributes: 'Currency',
                        results: currencyName.toUpperCase(),
                      ),
                locale == null
                    ? Container()
                    : DetailRow(
                        attributes: 'Locale',
                        results: locale.toString(),
                      ),
                marketCap == null
                    ? Container()
                    : DetailRow(
                        attributes: 'Market Cap',
                        results: marketCap.toString(),
                      ),
                market == null
                    ? Container()
                    : DetailRow(
                        attributes: 'Market',
                        results: market.toString().toUpperCase(),
                      ),
                outstandingShares == null
                    ? Container()
                    : DetailRow(
                        attributes: 'Outstanding Shares',
                        results: outstandingShares.toString(),
                      ),
                primaryExchange == null
                    ? Container()
                    : DetailRow(
                        attributes: 'Primary Exchange',
                        results: primaryExchange.toString(),
                      ),
                phone == null
                    ? Container()
                    : DetailRow(
                        attributes: 'Phone number',
                        results: phone.toString(),
                      ),
                state == null
                    ? Container()
                    : DetailRow(
                        attributes: 'State',
                        results: state,
                      ),
                city == null
                    ? Container()
                    : DetailRow(
                        attributes: 'City',
                        results: city,
                      ),
                postalCode == null
                    ? Container()
                    : DetailRow(
                        attributes: 'Postal Code',
                        results: postalCode.toString(),
                      ),
                address == null
                    ? Container()
                    : DetailRow(
                        attributes: 'Address',
                        results: address.toString(),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
