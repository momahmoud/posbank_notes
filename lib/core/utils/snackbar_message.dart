import 'package:flutter/material.dart';

import '../app_theme.dart';

class SnackBarMessage {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey,
        content: Text(
          message,
          style: TextStyle(color: secondaryColor),
        ),
      ),
    );
  }
}
