import 'package:flutter/material.dart';
import 'package:food_delivery_system/helpers/context_helpers.dart';
import 'package:food_delivery_system/views/home/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 800)).then((value) =>
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeView())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Center(
            child: Image.asset(
              "assets/logo_new.jpg",
            ),
          )),
    );
  }
}
