import 'package:ff_project/config.dart';
import 'package:ff_project/views/components/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/routes.dart';
import '../components/buttons.dart';
import '../components/curvedimages.dart';

class Profile extends StatefulWidget {
  Profile({
    super.key,
  });
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _username = '';
  String _email = '';
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getString('email') ?? '');
      _username = (prefs.getString('username') ?? '');
    });
  }

  String username = "";

  String email = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Align(
                    // alignment: Alignment.center,
                    child: carvedEdgeImage(
                      imageHeight: 200.0,
                      imageWidth: 130.0,
                      imageURL: 'assets/images/landimage2.jpg',
                      radius: 100.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                titleText(text: _username, color: primaryColor),
                const SizedBox(height: 10.0),
                messageText(text: _email, color: Colors.grey),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          titleText(text: "200", size: 20.0),
                          const SizedBox(height: 10.0),
                          messageText(text: "Collections"),
                        ],
                      ),
                      const Divider(
                        endIndent: 10,
                        indent: 10,
                        thickness: 1.0,
                      ),
                      Column(children: [
                        titleText(text: "200", size: 20.0),
                        const SizedBox(height: 10.0),
                        messageText(text: "Reservered"),
                      ]),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    elevatedButton(
                        text: 'Explore',
                        sizeWidth: 150.0,
                        sizeHeight: 70.0,
                        color: Colors.grey[400]),
                    const SizedBox(width: 10.0),
                    elevatedButton(
                      text: 'Settings',
                      sizeWidth: 150.0,
                      sizeHeight: 70.0,
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  width: 350,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Ink(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                    color: Colors.black87,
                                    width: 5,
                                    style: BorderStyle.none),
                                color: Colors.grey[200]),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(1000),
                              child: Center(child: titleText(text: '13')),
                            ),
                          ),
                          titleText(text: 'ShinCity Festival', size: 18.0),
                          const Icon(
                            Icons.favorite,
                            color: primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    try {
                      _prefs.remove('id');
                      _prefs.remove('token');
                    } catch (error) {
                      print(error);
                    }
                    Get.toNamed(RoutesClass.getLoginRoute());
                  },
                  child: messageText(color: primaryColor, text: "logout"),
                ),
              ],
              // color: Colors.pink,
            ),
          ),
        ),
      ),
    );
  }
}
