// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery_system/constants.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color color;
  final double? width;
  const MainButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.color = primary,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width ?? MediaQuery.of(context).size.width,
      height: kToolbarHeight * 0.9,
      onPressed: onPressed,
      color: color,
      elevation: 0,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
