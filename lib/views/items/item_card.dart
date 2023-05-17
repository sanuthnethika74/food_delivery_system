// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_delivery_system/constants.dart';
import 'package:food_delivery_system/helpers/context_helpers.dart';

import 'package:food_delivery_system/models/item_model.dart';
import 'package:food_delivery_system/views/items/item_view.dart';

class ItemCard extends StatelessWidget {
  final AnimationController animationController;
  final ItemModel itemModel;
  final Animation<Offset> animation;
  const ItemCard(
      {Key? key,
      required this.animationController,
      required this.itemModel,
      required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateHelper(
            context,
            ItemView(
              item: itemModel,
            ));
      },
      child: FadeTransition(
        opacity: animationController,
        child: SlideTransition(
          position: animation,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "$imageBaseUrl/${itemModel.productImages[0].imageUrl}",
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: ((context, error, stackTrace) => Image.network(
                        noImageUrl,
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(height: 8),
                Text(
                  itemModel.title,
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${itemModel.currenyCode} ${itemModel.unitPrice} / ${itemModel.quantity} ${itemModel.quantityMeasurementUnit}",
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
