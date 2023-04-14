import 'package:ff_project/config.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'package:ff_project/views/components/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
  int _reserved = 0;
  int _created_by_me = 0;
  String _upcomingEventName = '';
  String _upcomingEventDaysLeft = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _token = (_prefs.getString('token') ?? '');
    var headersList = {'Accept': '*/*', 'Authorization': 'token $_token'};

    var url = Uri.parse('$Api_url/user/profileStats/');

    var response = await http.get(url, headers: headersList);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> resJson = json.decode(response.body);
      setState(() {
        _reserved = resJson['reservations'];
        _created_by_me = resJson['created_by_me'];

        _email = resJson['email'];
        _username = resJson['username'];
        _upcomingEventName = resJson['upcoming_event']['event_name'];
        String _upcomingEventDate = resJson['upcoming_event']['date'];

        DateTime eventDate = DateFormat('yyyy-MM-dd').parse(_upcomingEventDate);
        _upcomingEventDaysLeft =
            eventDate.difference(DateTime.now()).inDays.toString();

        print(_upcomingEventDaysLeft);
      });
    } else {
      // throw "Error reading url";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text('Cant get profile info, you are online'),
      ));
    }
  }

  String username = "";

  String email = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Align(
                      // alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/logo.svg',
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  titleText(text: _username, color: primaryColor),
                  const SizedBox(height: 10.0),
                  messageText(text: _email, color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            titleText(
                                text: _created_by_me.toString(), size: 20.0),
                            const SizedBox(height: 10.0),
                            messageText(text: "My Events"),
                          ],
                        ),
                        const Divider(
                          endIndent: 10,
                          indent: 10,
                          thickness: 1.0,
                        ),
                        Column(children: [
                          titleText(text: _reserved.toString(), size: 20.0),
                          const SizedBox(height: 10.0),
                          messageText(text: "Reservered"),
                        ]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // elevatedButton(
                      //     text: 'Explore',
                      //     sizeWidth: 150.0,
                      //     sizeHeight: 70.0,
                      //     color: Colors.grey[400]),
                      // const SizedBox(width: 10.0),
                      elevatedButton(
                          function: () {
                            Get.toNamed(RoutesClass.uploadpage);
                          },
                          text: 'Create event',
                          sizeWidth: 150.0,
                          sizeHeight: 70.0,
                          radius: 15.0),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: 350,
                    child: Card(
                      elevation: 5.0,
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
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                      color: Colors.black87,
                                      width: 5,
                                      style: BorderStyle.none),
                                  color: Colors.grey[200]),
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(1000),
                                child: Center(
                                    child: titleText(
                                        text: '$_upcomingEventDaysLeft',
                                        size: 20.0)),
                              ),
                            ),
                            titleText(text: _upcomingEventName, size: 18.0),
                            const Icon(
                              Icons.bookmark_added_outlined,
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
                        _prefs.remove('reserved');
                        _prefs.remove('username');
                        _prefs.remove('email');
                      } catch (error) {
                        rethrow;
                      }
                      Get.toNamed(RoutesClass.getLoginRoute());
                    },
                    child: messageText(color: primaryColor, text: "logout"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
