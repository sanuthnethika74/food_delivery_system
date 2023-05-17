import 'dart:convert';

import 'package:food_delivery_system/constants.dart';
import 'package:food_delivery_system/controllers/auth/auth_controller.dart';
import 'package:food_delivery_system/helpers/error_helper.dart';
import 'package:food_delivery_system/models/user_model.dart';
import "package:http/http.dart" as http;

class AuthService {
  //signup user
  Future<bool> signupUser(User user) async {
    try {
      final url = Uri.parse("$baseUrl/auth/clientSignup");
      final res = await http.post(
        url,
        headers: {
          // "Content-Type": "application/json",
        },
        body: user.toJson(),
      );

      if (res.statusCode == 200) {
        return await loginUser(user.email, user.password);
      } else {
        return false;
      }
    } catch (e) {
      errrorPrint("Auth service", e.toString());
      return false;
    }
  }

  //login user
  Future<bool> loginUser(String email, String password) async {
    try {
      final url = Uri.parse("$baseUrl/auth/login");
      final res = await http.post(
        url,
        body: {"email": email, "password": password, "deviceType": "mobile"},
      );
      if (res.statusCode == 200) {
        String token = jsonDecode(res.body)["token"];
        final _authController = AuthController();
        _authController.setToken = token;
        _authController.saveToken(token);
      }
      return res.statusCode == 200;
    } catch (e) {
      errrorPrint("Auth service", e.toString());
      return false;
    }
  }
}
