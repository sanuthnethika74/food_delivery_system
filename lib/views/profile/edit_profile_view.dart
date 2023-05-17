// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery_system/helpers/context_helpers.dart';
import 'package:food_delivery_system/services/profile_service.dart';
import 'package:food_delivery_system/widgets/custom_input_field.dart';
import 'package:food_delivery_system/widgets/main_button.dart';
import 'package:food_delivery_system/widgets/main_loader.dart';

class EditProfileView extends StatefulWidget {
  final Map data;
  const EditProfileView({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool shouldLoad = false;
  @override
  void initState() {
    setState(() {
      firstName.text = widget.data["firstName"] ?? "";
      lastName.text = widget.data["lastName"] ?? "";
      email.text = widget.data["email"] ?? "";
      mobileNo.text = widget.data["mobileNo"] ?? "";
      address.text = widget.data["address"] ?? "";
      city.text = widget.data["city"] ?? "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          alignment: Alignment.center,
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputField(
                  hintText: "First Name",
                  isPassword: false,
                  textEditingController: firstName,
                  textInputType: TextInputType.text,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter first name",
                ),
                InputField(
                  hintText: "Last Name",
                  isPassword: false,
                  textEditingController: lastName,
                  textInputType: TextInputType.text,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter last name",
                ),
                InputField(
                  hintText: "Email",
                  isPassword: false,
                  textEditingController: email,
                  textInputType: TextInputType.text,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter email",
                ),
                InputField(
                  hintText: "Mobile Number",
                  isPassword: false,
                  textEditingController: mobileNo,
                  textInputType: TextInputType.text,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter mobile number",
                ),
                InputField(
                  hintText: "Address",
                  isPassword: false,
                  textEditingController: address,
                  textInputType: TextInputType.text,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter address",
                ),
                InputField(
                  hintText: "City",
                  isPassword: false,
                  textEditingController: city,
                  textInputType: TextInputType.text,
                  enabled: true,
                  shouldValidate: true,
                  validateMessage: "Please enter address",
                ),
                const SizedBox(
                  height: 8,
                ),
                shouldLoad
                    ? const MainLoader()
                    : MainButton(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            Map data = {
                              "firstName": firstName.text,
                              "lastName": lastName.text,
                              "city": city.text,
                              "address": address.text,
                              "mobileNo": mobileNo.text,
                              "deliveryCity": "deliveryCity",
                              "deliveryAddress": "deliveryAddress"
                            };
                            setState(() {
                              shouldLoad = true;
                            });
                            await ProfileService()
                                .updateProfile(data)
                                .then((value) {
                              if (value) {
                                scaffoldMessager(
                                    context, "Profile updated succesfully");
                                Navigator.pop(context);
                              } else {
                                scaffoldMessager(context,
                                    "Update profile failed,Please try again");
                              }
                            });
                            setState(() {
                              shouldLoad = false;
                            });
                          }
                        },
                        title: "Update Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
