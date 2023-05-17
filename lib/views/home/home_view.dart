import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_system/views/cart/cart_view.dart';

import 'package:food_delivery_system/views/items/items_view.dart';
import 'package:food_delivery_system/views/notifications/notification_view.dart';
import 'package:food_delivery_system/views/orders/orders_view.dart';
import 'package:food_delivery_system/views/profile/user_profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  List<Widget> get bodyItems => const [
        ItemsView(),
        CartView(),
        NotificationView(),
        UserProfileView(),
        OrdersView(),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyItems[_selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.notifications),
            title: const Text('Notifications'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.shop),
            title: const Text('Orders'),
          ),
        ],
      ),
    );
  }
}
