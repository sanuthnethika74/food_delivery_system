import 'dart:convert';

import 'package:food_delivery_system/helpers/error_helper.dart';
import 'package:food_delivery_system/helpers/get_request.dart';
import 'package:food_delivery_system/models/shipped_order_model.dart';

class OrderService {
  Future<List<ShippedOrderModel>> getOrders() async {
    try {
      final response = await GetRequest().getRequest("home/getMyShippedOrders");
      final json = jsonDecode(response.body);
      final List data = json["data"];

      List<ShippedOrderModel> orders =
          data.map((e) => ShippedOrderModel.fromJson(e)).toList();
      return orders;
    } catch (e) {
      errrorPrint("Order service : ", "get orders failed $e");
      return [];
    }
  }
}
