import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_system/constants.dart';
import 'package:food_delivery_system/controllers/auth/auth_controller.dart';
import 'package:food_delivery_system/helpers/context_helpers.dart';
import 'package:food_delivery_system/models/item_model.dart';
import 'package:food_delivery_system/services/item_service.dart';

class ItemView extends StatefulWidget {
  final ItemModel item;
  const ItemView({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  int quantity = 1;

  final _itemService = ItemService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        child: ListView(
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.item.productImages.isNotEmpty)
              widget.item.productImages.length == 1
                  ? Image.network(
                      "$imageBaseUrl/${widget.item.productImages[0].imageUrl}")
                  : CarouselSlider(
                      options: CarouselOptions(height: 400.0),
                      items: widget.item.productImages
                          .map(
                            (e) => Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                              child: Image.network(
                                "$imageBaseUrl/${widget.item.productImages[0].imageUrl}",
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.network(
                                  noImageUrl,
                                ),
                              ),
                            ),
                          )
                          .toList()),
            Text(
              widget.item.title,
              style: Theme.of(context).textTheme.headline3,
            ),
            const Divider(),
            Text(
              widget.item.description,
            ),
            const Divider(),
            Text(
              "${widget.item.currenyCode}  ${widget.item.unitPrice} / ${widget.item.quantity} ${widget.item.quantityMeasurementUnit}",
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity <= 1) {
                            return;
                          }
                          setState(() {
                            quantity--;
                          });
                        },
                        icon: const Icon(Icons.remove_circle),
                      ),
                      Chip(
                        label: Text(quantity.toString()),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(
                          Icons.add_circle,
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  elevation: 00,
                  color: red,
                  onPressed: () async {
                    if (await AuthController().getToken() != null) {
                      _itemService
                          .addToCart(widget.item.id, quantity.toString(),
                              widget.item.unitMeasurementType)
                          .then((value) {
                        if (value) {
                          scaffoldMessager(context, "Added to card");
                          setState(() {
                            quantity = 1;
                          });
                        } else {
                          scaffoldMessager(context, "Add to cart failed");
                        }
                      });
                    } else {
                      scaffoldMessager(context, "Please login to your account");
                    }
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
