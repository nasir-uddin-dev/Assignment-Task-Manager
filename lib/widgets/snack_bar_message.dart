import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.deepPurpleAccent,
      content: Center(
        child: Text(
          message,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
