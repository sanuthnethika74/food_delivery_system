import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery_system/helpers/get_request.dart';
import 'package:food_delivery_system/models/cart_item_model.dart';
import 'package:food_delivery_system/models/item_model.dart';
import 'package:get/get.dart';

class ItemController {
  Future<List<ItemModel>> getItems(int page, {String? search}) async {
    try {
      String url = "home/getAllProducts?page=$page&perPage=12&search=$search";
      final response = await GetRequest().getRequest(url);
      final jsonData = jsonDecode(response.body);
      List data = jsonData["data"]["data"];
      List<ItemModel> items = data.map((e) => ItemModel.fromMap(e)).toList();
      return items;
    } catch (e) {
      debugPrint("get items failed $e");
      return [];
    }
  }

  Future<List<Product>> getCartItems() async {
    try {
      String url = "cart/myCartDetails";
      final response = await GetRequest().getRequest(url);
      final jsonData = jsonDecode(response.body);

      List data = jsonData["data"];

      List<Product> items = data.map((e) => Product.fromJson(e)).toList();
      return items;
    } catch (e) {
      debugPrint("get items failed $e");
      return [];
    }
  }
}
