import "package:flutter/material.dart";

import 'package:food_delivery_system/constants.dart';

import 'package:food_delivery_system/controllers/items/item_controller.dart';
import 'package:food_delivery_system/helpers/context_helpers.dart';
import 'package:food_delivery_system/models/item_model.dart';
import 'package:food_delivery_system/views/items/item_card.dart';
import 'package:food_delivery_system/views/items/item_view.dart';
import 'package:food_delivery_system/views/notifications/notification_view.dart';
import 'package:food_delivery_system/widgets/main_loader.dart';

class ItemsView extends StatefulWidget {
  const ItemsView({super.key});

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView>
    with SingleTickerProviderStateMixin {
  final ItemController _itemController = ItemController();
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  late final ScrollController _controller;
  int pageNumber = 1;
  List<ItemModel> items = [];
  bool shouldLoad = false;
  bool _loading = false;
  Future<void> _loadItems() async {
    setState(() {
      _loading = true;
    });
    await _itemController.getItems(pageNumber).then((value) => setState(() {
          items.addAll(value);
          items = items.toSet().toList();
          shouldLoad = false;
          _loading = false;
        }));
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
    _controller = ScrollController();
    setState(() {
      shouldLoad = true;
    });
    _loadItems();

    _controller.addListener(() {
      final double maxPos = _controller.position.maxScrollExtent;
      final double triggerPos = maxPos * 3 / 4;
      double currentPos = _controller.position.pixels;

      if (currentPos >= triggerPos) {
        _loadItems();
        pageNumber++;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(defaultPadding),
      child: shouldLoad
          ? const MainLoader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Discover more",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        "Good things are waiting for you",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: items.isEmpty
                        ? const Center(
                            child: Text("No Results"),
                          )
                        : GridView.count(
                            controller: _controller,
                            primary: false,
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            children: [
                                ...items
                                    .map((e) => ItemCard(
                                        animationController:
                                            _animationController,
                                        itemModel: e,
                                        animation: _animation))
                                    .toList(),
                                _loading
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ]))
              ],
            ),
    );
  }
}
