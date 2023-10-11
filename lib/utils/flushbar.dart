import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class MyFlushBar {
  static void showSimpleFlushBar(
     String message,
     BuildContext context,
    Color? backgroundColor,
    Color? textColor,
  ) {
    Flushbar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor ?? Colors.white),
      ),
      shouldIconPulse: true,
      backgroundColor: backgroundColor ?? Colors.blue, // Default background color
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 2),
    ).show(context);
  }
}

