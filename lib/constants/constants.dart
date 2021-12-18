import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const apiKey = 'eOCFJBzA6Pykt62Zq5MFBGXKIIIho4nS';
const kTickerEndPoint =
    'https://api.polygon.io/v3/reference/tickers?&market=stocks&active=true&sort=ticker&order=asc&limit=20&apiKey=$apiKey';
const kTickerSearchEndPoint =
    'https://api.polygon.io/v3/reference/tickers?search=';

const kTickerDetailsEndPoint = 'https://api.polygon.io/vX/reference/tickers/';

const kThemeColor = Color(0xFF0A0E21);

TextStyle kLoadingText() {
  return GoogleFonts.raleway(
    fontSize: 20,
  );
}
