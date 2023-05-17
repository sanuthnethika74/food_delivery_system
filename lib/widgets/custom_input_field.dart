// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery_system/constants.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final bool isPassword;
  final TextEditingController textEditingController;
  final void Function(String)? onChanged;
  final TextInputType textInputType;
  final bool enabled;
  final bool shouldValidate;
  final String validateMessage;

  const InputField(
      {Key? key,
      required this.hintText,
      this.errorText,
      required this.isPassword,
      required this.textEditingController,
      this.onChanged,
      required this.textInputType,
      required this.enabled,
      required this.shouldValidate,
      this.validateMessage = "Please fill this field"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: MediaQuery.of(context).size.width,
      height: kToolbarHeight,
      child: TextFormField(
        obscureText: isPassword,
        controller: textEditingController,
        keyboardType: textInputType,
        onChanged: onChanged,
        enabled: enabled,
        decoration: InputDecoration(
            labelText: hintText,
            filled: true,
            fillColor: primary.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none,
            )),
        validator: shouldValidate
            ? (val) => val != null
                ? val.isEmpty
                    ? validateMessage
                    : null
                : null
            : null,
      ),
    );
  }
}
