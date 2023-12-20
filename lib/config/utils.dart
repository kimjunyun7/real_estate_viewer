import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text, {Color color = Colors.red}) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: color);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Future showIndicatorDialog(context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator()
                  : const CupertinoActivityIndicator(),
            ));
  }
}
