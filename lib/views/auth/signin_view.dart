import 'package:flutter/material.dart';

import 'package:food_delivery_system/constants.dart';
import 'package:food_delivery_system/helpers/context_helpers.dart';
import 'package:food_delivery_system/services/auth_service.dart';
import 'package:food_delivery_system/views/home/home_view.dart';
import 'package:food_delivery_system/views/auth/signup_view.dart';
import 'package:food_delivery_system/widgets/custom_input_field.dart';
import 'package:food_delivery_system/widgets/main_button.dart';
import 'package:food_delivery_system/widgets/main_loader.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Image.asset("assets/logo_new.png"),
              InputField(
                hintText: "Email",
                isPassword: false,
                textEditingController: _email,
                textInputType: TextInputType.emailAddress,
                enabled: true,
                shouldValidate: true,
              ),
              InputField(
                hintText: "Password",
                isPassword: true,
                textEditingController: _password,
                textInputType: TextInputType.emailAddress,
                enabled: true,
                shouldValidate: true,
              ),
              loading
                  ? const MainLoader()
                  : MainButton(
                      onPressed: () async {
                        setState(() {
                          loading = !loading;
                        });
                        await AuthService()
                            .loginUser(_email.text, _password.text)
                            .then((value) {
                          if (value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeView()));
                          } else {
                            scaffoldMessager(
                                context, "Signin failed, Please try again");
                          }
                        });
                        setState(() {
                          loading = !loading;
                        });
                      },
                      title: "Login",
                    ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Don't have an account ?"),
                  TextButton(
                    onPressed: () {
                      navigateHelper(context, SignupView());
                    },
                    child: const Text("Signup"),
                  ),
                  const Text("now"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
