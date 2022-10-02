import 'package:flutter/material.dart';

class MessageHandler {
  static void showSnackBar(var _scaffoldKey, String message) {
    _scaffoldKey.currentState!.hideCurrentSnackBar();
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Colors.purple,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.white),
        )));
  }
}
