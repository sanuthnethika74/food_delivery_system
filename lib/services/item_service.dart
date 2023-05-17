import 'dart:convert';

import 'package:food_delivery_system/constants.dart';
import 'package:food_delivery_system/controllers/auth/auth_controller.dart';
import 'package:food_delivery_system/helpers/error_helper.dart';
import 'package:food_delivery_system/models/checkout_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ItemService {
  final AuthController _authController = Get.put(AuthController());
  Future<bool> addToCart(
      String productId, String selectedQuantity, String measurementType) async {
    try {
      String token = await _authController.getToken() ?? "";
      Uri url = Uri.parse("$baseUrl/cart/create");
      final res = await http.post(url, headers: {
        "Authorization": "Bearer $token",
      }, body: {
        "productId": productId,
        "selectedMeasurementType": measurementType,
        "selectedQuantity": selectedQuantity
      });

      return res.statusCode == 200;
    } catch (e) {
      errrorPrint("Item service", "add to card failed $e");
      return false;
    }
  }

  Future<bool> checkout(CheckoutResponse checkoutResponse) async {
    try {
      Uri url = Uri.parse("$baseUrl/cart/checkoutOneItem");
      String token = await _authController.getToken() ?? "";
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: checkoutResponse.toJson(),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
