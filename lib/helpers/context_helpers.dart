import 'package:flutter/material.dart';

void navigateHelper(BuildContext context, Widget child) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => child));
}

void scaffoldMessager(BuildContext context, String message) {
  final SnackBar snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
