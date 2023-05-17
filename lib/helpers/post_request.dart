import 'package:food_delivery_system/constants.dart';
import 'package:http/http.dart' as http;

class PosRequest {
  Future<http.Response> postRequest(
    String url, {
    bool shouldAuthenticate = false,
  }) async {
    return http.post(
      Uri.parse(
        "$baseUrl/$url",
      ),
    );
  }
}
