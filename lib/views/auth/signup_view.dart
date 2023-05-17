import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_system/constants.dart';
import 'package:food_delivery_system/helpers/context_helpers.dart';
import 'package:food_delivery_system/models/user_model.dart';
import 'package:food_delivery_system/services/auth_service.dart';
import 'package:food_delivery_system/views/auth/signin_view.dart';
import 'package:food_delivery_system/views/home/home_view.dart';
import 'package:food_delivery_system/widgets/custom_input_field.dart';
import 'package:food_delivery_system/widgets/main_button.dart';
import 'package:food_delivery_system/widgets/main_loader.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastNmme = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool shouldLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputField(
                  hintText: "First Name",
                  isPassword: false,
                  textEditingController: firstName,
                  textInputType: TextInputType.name,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter your first name",
                ),
                InputField(
                  hintText: "Last Name",
                  isPassword: false,
                  textEditingController: lastNmme,
                  textInputType: TextInputType.name,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter your last name",
                ),
                InputField(
                  hintText: "Mobile Number",
                  isPassword: false,
                  textEditingController: mobileNo,
                  textInputType: TextInputType.text,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter your mobile number",
                ),
                InputField(
                  hintText: "Email",
                  isPassword: false,
                  textEditingController: email,
                  textInputType: TextInputType.emailAddress,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter your email ",
                ),
                InputField(
                  hintText: "City",
                  isPassword: false,
                  textEditingController: city,
                  textInputType: TextInputType.name,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter your city ",
                ),
                InputField(
                  hintText: "Address",
                  isPassword: false,
                  textEditingController: address,
                  textInputType: TextInputType.name,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter your address",
                ),
                InputField(
                  hintText: "Password",
                  isPassword: true,
                  textEditingController: password,
                  textInputType: TextInputType.visiblePassword,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter password",
                ),
                InputField(
                  hintText: "Confirm Password",
                  isPassword: true,
                  textEditingController: confirmPassword,
                  textInputType: TextInputType.visiblePassword,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter confirm password",
                ),
                shouldLoad
                    ? const MainLoader()
                    : MainButton(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            if (password.text == confirmPassword.text) {
                              setState(() {
                                shouldLoad = true;
                              });
                              User user = User(
                                firstName: firstName.text,
                                lastName: lastNmme.text,
                                email: email.text,
                                mobileNo: mobileNo.text,
                                city: city.text,
                                address: address.text,
                                password: password.text,
                                confirmPassword: confirmPassword.text,
                              );
                              await AuthService()
                                  .signupUser(user)
                                  .then((value) {
                                if (value) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeView()));
                                } else {
                                  scaffoldMessager(context,
                                      "Signup failed, please try again");
                                }
                              });
                            } else {
                              scaffoldMessager(
                                  context, "Confirm password failed");
                            }
                            setState(() {
                              shouldLoad = false;
                            });
                          }
                        },
                        title: "Sign Up",
                        color: primary,
                      ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Already have an account ? ",
                    ),
                    TextButton(
                      onPressed: () {
                        navigateHelper(context, SigninView());
                      },
                      child: const Text("Login"),
                    ),
                    const Text("now")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
