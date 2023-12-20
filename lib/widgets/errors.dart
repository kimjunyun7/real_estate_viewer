import 'package:flutter/material.dart';

class Errors {
  static Widget showFutureError() => SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: const Text('Error'),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      );
}
