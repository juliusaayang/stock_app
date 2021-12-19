import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthService with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future register(String email, String password) async {
    try {
      setLoading(true);
      UserCredential authResult =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = authResult.user;
      setMessage(null);
      setLoading(false);

      return user;
    } on SocketException {
      setLoading(false);
      setMessage("Check your internet settings");
    } on PlatformException {
      setLoading(false);

      setMessage("Failed");
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      if (e.code == "invalid-email") {
        setMessage("Invalid email address");
      }
      if (e.code == "wrong-password") {
        setMessage("Incorrect password");
      }
      if (e.code == "network-request-failed") {
        setMessage("Connect to the internet");
      }
      if (e.code == "email-already-in-use") {
        setMessage("An account already exist for this email");
      }
      if (e.code == "user-not-found") {
        setMessage("No user found for this email");
      }
      print('failed with error code: ${e.code}');
      print(e.message);
    } catch (e) {
      setLoading(false);
      setMessage(e);
    }
    notifyListeners();
  }

  Future signIn(String email, String password) async {
    try {
      setLoading(true);
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = authResult.user;
      setMessage(null);
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage("Check your internet settings");
    } on PlatformException {
      setLoading(false);

      setMessage("Failed");
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      if (e.code == "invalid-email") {
        setMessage("Invalid email address");
      }
      if (e.code == "wrong-password") {
        setMessage("Incorrect password");
      }
      if (e.code == "network-request-failed") {
        setMessage("Connect to the internet");
      }
      if (e.code == "email-already-in-use") {
        setMessage("An account already exist for this email");
      }
      if (e.code == "user-not-found") {
        setMessage("No user found for this email");
      }
      print('failed with error code: ${e.code}');
      print(e.message);
    } catch (e) {
      setLoading(false);
    }
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }

  Stream<User?> get user => firebaseAuth.authStateChanges().map(
        (event) => event,
      );
}
