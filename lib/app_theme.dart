import 'package:flutter/material.dart';

ThemeData get themeData => ThemeData(
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.grey,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.grey,
          ),
          titleTextStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          )),
      fontFamily: "Roboto",
    );
