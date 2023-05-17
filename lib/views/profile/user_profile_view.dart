import 'package:flutter/material.dart';
import 'package:food_delivery_system/constants.dart';
import 'package:food_delivery_system/helpers/context_helpers.dart';
import 'package:food_delivery_system/services/profile_service.dart';
import 'package:food_delivery_system/views/auth/signin_view.dart';
import 'package:food_delivery_system/views/profile/edit_profile_view.dart';
import 'package:food_delivery_system/widgets/main_button.dart';
import 'package:food_delivery_system/widgets/main_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  Map userData = {};
  bool shouldLoad = false;
  @override
  void initState() {
    setState(() {
      shouldLoad = true;
    });
    ProfileService().getProfileData().then((value) => setState(() {
          userData = value;
          shouldLoad = false;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SigninView()));
            },
            child: Text(
              "Signout",
            ),
          ),
        ],
      ),
      body: shouldLoad
          ? const MainLoader()
          : RefreshIndicator(
              onRefresh: () async {
                await ProfileService()
                    .getProfileData()
                    .then((value) => setState(() {
                          userData = value;
                          shouldLoad = false;
                        }));
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                                "$imageBaseUrl/${userData['profilePic']}",
                                fit: BoxFit.cover,
                                errorBuilder: ((context, error, stackTrace) =>
                                    const Icon(
                                      Icons.error,
                                    ))),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Text(
                              '${userData['firstName']} ${userData['lastName']}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Email'),
                      subtitle: Text(userData['email']),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Mobile Number'),
                      subtitle: Text(userData['mobileNo']),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_city),
                      title: Text('City'),
                      subtitle: Text(userData['userDetail']['city']),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text('Address'),
                      subtitle: Text(userData['userDetail']['address']),
                    ),
                    SizedBox(height: 20),
                    MainButton(
                      onPressed: () {
                        navigateHelper(
                            context,
                            EditProfileView(
                              data: userData,
                            ));
                      },
                      title: 'Edit Profile',
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
