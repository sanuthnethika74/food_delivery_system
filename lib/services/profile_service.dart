import 'dart:convert';
import 'package:food_delivery_system/constants.dart';
import 'package:food_delivery_system/controllers/auth/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:food_delivery_system/helpers/get_request.dart';

class ProfileService {
  Future<Map> getProfileData() async {
    final response = await GetRequest().getRequest("auth/myProfile");
    final json = jsonDecode(response.body);
    return json["data"];
  }

  Future<bool> updateProfile(Map data) async {
    try {
      String token = await AuthController().getToken() ?? "";
      final res = await http.post(
        Uri.parse(
          "$baseUrl/auth/updateMyProfile",
        ),
        headers: {"Authorization": "Bearer $token"},
        body: data,
      );
      print(jsonDecode(res.body));
      return res.statusCode == 200;
    } catch (e) {
      print("update profile failed $e");
      return false;
    }
  }
}
