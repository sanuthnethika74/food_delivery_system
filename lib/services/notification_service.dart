import 'dart:convert';

import 'package:food_delivery_system/helpers/get_request.dart';
import 'package:food_delivery_system/models/notification_model.dart';

class NotificationService {
  final GetRequest _getRequest = GetRequest();
  Future<void> markAllNotificationsAsRead() async {
    await _getRequest.getRequest("dashboard/markAllAsRead");
  }

  Future<List<Notification>> getNotifications() async {
    try {
      final response = await _getRequest.getRequest("dashboard/notification");
      final json = jsonDecode(response.body);
      final List data = json["data"]["notifications"];
      List<Notification> notifications =
          data.map((e) => Notification.fromJson(e)).toList();
      return notifications;
    } catch (e) {
      return [];
    }
  }
}
