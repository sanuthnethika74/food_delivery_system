import 'package:flutter/material.dart';
import 'package:food_delivery_system/app_theme.dart';
import 'package:food_delivery_system/controllers/auth/auth_controller.dart';
import 'package:food_delivery_system/views/auth/signup_view.dart';
import 'package:food_delivery_system/views/home/home_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(theme: themeData,
        debugShowCheckedModeBanner: false,
        home: HomeView());
  }
}
