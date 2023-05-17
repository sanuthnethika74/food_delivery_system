// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery_system/controllers/items/item_controller.dart';
import 'package:food_delivery_system/helpers/context_helpers.dart';

import 'package:food_delivery_system/models/cart_item_model.dart';
import 'package:food_delivery_system/models/checkout_model.dart';
import 'package:food_delivery_system/services/item_service.dart';
import 'package:food_delivery_system/views/home/home_view.dart';
import 'package:food_delivery_system/widgets/custom_input_field.dart';
import 'package:food_delivery_system/widgets/main_button.dart';
import 'package:food_delivery_system/widgets/main_loader.dart';

class CheckoutView extends StatefulWidget {
  final Product product;
  const CheckoutView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _cardNumber = TextEditingController();
  TextEditingController _csv = TextEditingController();
  TextEditingController _expiry = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  bool shouldLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Bill : ${widget.product.productDetails.currencyCode} ${widget.product.selectedQuantity * widget.product.productDetails.unitPrice}",
                style: Theme.of(context).textTheme.headline5,
              ),
              InputField(
                hintText: "Card Number",
                isPassword: true,
                textEditingController: _cardNumber,
                textInputType: TextInputType.name,
                enabled: true,
                shouldValidate: true,
                validateMessage: "Please enter card number",
              ),
              InputField(
                hintText: "CSV",
                isPassword: true,
                textEditingController: _csv,
                textInputType: TextInputType.name,
                enabled: true,
                shouldValidate: true,
                validateMessage: "Please enter csv",
              ),
              InputField(
                hintText: "Expire Date (2023-08)",
                isPassword: true,
                textEditingController: _expiry,
                textInputType: TextInputType.name,
                enabled: true,
                shouldValidate: true,
                validateMessage: "Please enter expire date",
              ),
              InputField(
                hintText: "First Name",
                isPassword: true,
                textEditingController: _firstName,
                textInputType: TextInputType.name,
                enabled: true,
                shouldValidate: true,
                validateMessage: "Please enter first name",
              ),
              InputField(
                hintText: "Last Name",
                isPassword: true,
                textEditingController: _lastName,
                textInputType: TextInputType.name,
                enabled: true,
                shouldValidate: true,
                validateMessage: "Please enter last name",
              ),
              const SizedBox(height: 16.0),
              shouldLoad
                  ? const MainLoader()
                  : MainButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            shouldLoad = !shouldLoad;
                          });
                          CheckoutResponse _ch = CheckoutResponse(
                            cardNumber: _cardNumber.text,
                            csv: _csv.text,
                            expiry: _expiry.text,
                            firstName: _firstName.text,
                            lastName: _lastName.text,
                            measurementType:
                                widget.product.selectedMeasurementType,
                            productId: widget.product.productDetails.id,
                            quantity:
                                widget.product.selectedQuantity.toString(),
                            totalAmount: (widget.product.selectedQuantity *
                                    widget.product.productDetails.unitPrice)
                                .toString(),
                          );
                          await ItemService().checkout(_ch).then((value) {
                            if (value) {
                              scaffoldMessager(
                                  context, "Checkout successfully");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeView()));
                            } else {
                              scaffoldMessager(
                                  context, "Checkout failed,Please try again");
                            }
                          });
                          setState(() {
                            shouldLoad = !shouldLoad;
                          });
                        }
                      },
                      title: "Checkout",
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
