import 'package:flutter/material.dart';
import 'package:stock/constants/constants.dart';

class ErrorCustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
            ),
            Text(
              'something went wrong !!',
              style: kLoadingText(),
            ),
          ],
        ),
      ),
    );
  }
}
