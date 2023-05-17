import 'package:food_delivery_system/constants.dart';
import 'package:food_delivery_system/controllers/auth/auth_controller.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

class GetRequest {
  final _authController = Get.put(AuthController());
  Future<http.Response> getRequest(
    String url, {
    bool shouldAuthenitcate = true,
  }) async {
    String? token = await _authController.getToken();
    return http.get(
        Uri.parse(
          "$baseUrl/$url",
        ),
        headers: shouldAuthenitcate
            ? {
                "Authorization": "Bearer $token",
              }
            : {});
  }
}
