import 'package:flutter/material.dart';
import 'package:food_delivery_system/constants.dart';
import 'package:food_delivery_system/services/notification_service.dart';
import "package:food_delivery_system/models/notification_model.dart" as n;

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationService _notificationService = NotificationService();
  bool shouldLoad = false;
  List<n.Notification> notifications = [];

  @override
  void initState() {
    setState(() {
      shouldLoad = true;
    });
    _notificationService.getNotifications().then((value) => setState(() {
          notifications = value;
          shouldLoad = false;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          TextButton(
            onPressed: () async {
              setState(() {
                shouldLoad = !shouldLoad;
              });
              await _notificationService.markAllNotificationsAsRead();
              await _notificationService
                  .getNotifications()
                  .then((value) => setState(() {
                        notifications = value;
                        shouldLoad = false;
                      }));
              setState(() {
                shouldLoad = false;
              });
            },
            child: const Text("Mark all as read"),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            if (shouldLoad)
              const LinearProgressIndicator(
                color: primary,
              ),
            notifications.isEmpty
                ? const Center(
                    child: Text("No notifications"),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(
                                    Icons.nat,
                                  ),
                                  title: Text(notifications[index].message),
                                ),
                                const Divider()
                              ],
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
