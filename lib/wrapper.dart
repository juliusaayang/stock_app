import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock/pages/stock_list.dart';

import 'authentication/authentication.dart';

class Wrapper extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    
    if (user != null) {
      return Stocks();
    } else {
      return Authentication();
    }
  }
}
