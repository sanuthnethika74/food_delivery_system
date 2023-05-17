// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery_system/constants.dart';

import 'package:food_delivery_system/models/cart_item_model.dart';

class CartItemCar extends StatelessWidget {
  final Product item;
  final Animation<double> animation;
  final AnimationController animationController;
  const CartItemCar({
    Key? key,
    required this.item,
    required this.animation,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      "$imageBaseUrl/${item.productDetails.productImages[0].imageUrl}",
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) =>
                          const Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.productDetails.title,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${item.productDetails.currencyCode} ${item.productDetails.unitPrice}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${item.selectedQuantity} ${item.selectedMeasurementType}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
