import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_system/constants.dart';
import 'package:food_delivery_system/controllers/auth/auth_controller.dart';
import 'package:food_delivery_system/controllers/items/item_controller.dart';
import 'package:food_delivery_system/helpers/context_helpers.dart';
import 'package:food_delivery_system/views/auth/signin_view.dart';
import 'package:food_delivery_system/views/cart/cart_item_card.dart';
import 'package:food_delivery_system/views/items/checkout_view.dart';
import 'package:food_delivery_system/widgets/main_loader.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );
  bool authenticated = false;

  @override
  void initState() {
    AuthController().getToken().then((value) => setState(() {
          authenticated = value != null;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("My Cart"),
        ),
        body: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: !authenticated
              ? Center(
                  child: MaterialButton(
                      color: primary,
                      onPressed: () {
                        navigateHelper(context, SigninView());
                      },
                      child: const Text("Signin First")),
                )
              : FutureBuilder(
                  future: ItemController().getCartItems(),
                  builder: ((context, snapshot) => !snapshot.hasData
                      ? const MainLoader()
                      : snapshot.data!.isEmpty
                          ? const Center(
                              child: Text("No items availble in the cart"),
                            )
                          : GridView.count(
                              primary: false,
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              padding: const EdgeInsets.all(8),
                              children: snapshot.data!
                                  .map(
                                    (e) => InkWell(
                                        onTap: () {
                                          navigateHelper(
                                              context,
                                              CheckoutView(
                                                product: e,
                                              ));
                                        },
                                        child: CartItemCar(
                                            item: e,
                                            animation: _animation,
                                            animationController: _controller)),
                                  )
                                  .toList(),
                            )),
                ),
        ));
  }
}
