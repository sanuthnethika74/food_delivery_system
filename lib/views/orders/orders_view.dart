import 'package:flutter/material.dart';
import 'package:food_delivery_system/constants.dart';
import 'package:food_delivery_system/models/shipped_order_model.dart';
import 'package:food_delivery_system/services/order_service.dart';
import 'package:food_delivery_system/widgets/main_loader.dart';
import 'package:intl/intl.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _animation;
  bool shouldLoad = false;
  List<ShippedOrderModel> orders = [];
  @override
  void initState() {
    OrderService().getOrders().then((value) => setState(() {
          orders = value;
        }));
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    super.initState();
  }

  void _showDetails(ShippedOrderModel order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Product Name: ${order.productId.title}',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Quantity: ${order.quantity}',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Total Amount: ${order.currencyCode} ${order.totalAmount}',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Order Date: ${DateFormat.yMMMMd().format(order.date)}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipped Orders"),
        automaticallyImplyLeading: false,
      ),
      body: shouldLoad
          ? const MainLoader()
          : orders.isEmpty
              ? const Center(
                  child: Text("No orders available"),
                )
              : Container(
                  child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        final order = orders[index];
                        return GestureDetector(
                            onTap: () => _showDetails(order),
                            child: SlideTransition(
                                position: _animation,
                                child: Card(
                                    elevation: 3,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                order.productId.title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Expanded(
                                                child: Image.network(
                                                  "$imageBaseUrl/${order.productId.productImages[0].imageUrl}",
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                '${order.currencyCode} ${order.totalAmount}',
                                              )
                                            ])))));
                      }),
                ),
    );
  }
}
