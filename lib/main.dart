import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock/constants/constants.dart';
import 'package:stock/services/auth_service.dart';
import 'package:stock/services/connectivity_provider.dart';
import 'package:stock/widgets/error_custom_widget.dart';
import 'package:stock/wrapper.dart';

void main() {
  runApp(
    Home(),
  );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            theme: ThemeData.dark().copyWith(
                primaryColor: kThemeColor,
                scaffoldBackgroundColor: kThemeColor,
                appBarTheme: AppBarTheme(
                  centerTitle: true,
                  color: kThemeColor,
                ),
              ),
            home: ErrorCustomWidget(),
          );
        } else if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthService>.value(
                value: AuthService(),
              ),
              StreamProvider<User?>.value(
                value: AuthService().user,
                initialData: null,
              ),
              ChangeNotifierProvider(
                create: (context) => ConnectivityProvider(),
                child: Wrapper(),
              ),
            ],
            child: MaterialApp(
              theme: ThemeData.dark().copyWith(
                primaryColor: kThemeColor,
                scaffoldBackgroundColor: kThemeColor,
                appBarTheme: AppBarTheme(
                  centerTitle: true,
                  color: kThemeColor,
                ),
              ),
              debugShowCheckedModeBanner: false,
              home: Wrapper(),
            ),
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
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
            ),
          );
        }
      },
    );
  }
}
