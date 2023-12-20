import 'dart:developer';

import 'package:flutter/material.dart';

class Dialogs {
  static Future buildDialogWithList(
    context, {
    required String title,
    dynamic list,
    var onClickItem,
  }) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          height: 400.0,
          width: 300.0,
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                child: ListTile(
                  title: Text(list[i].toString()),
                ),
                onTap: () {
                  onClickItem(list[i]);
                },
              );
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
