import 'dart:convert';

import 'package:ff_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'components/buttons.dart';
import 'components/curvedimages.dart';
import 'components/texts.dart';
import '../helper/sharedPref.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pwcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    pwcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 270,
                width: 230,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    carvedEdgeImage(
                      imageHeight: 200.0,
                      imageWidth: 130.0,
                      imageURL: 'assets/images/landimage2.jpg',
                      radius: 100.0,
                    ),
                    Positioned(
                      bottom: 20,
                      right: 10,
                      child: carvedEdgeImage(
                        imageHeight: 200.0,
                        imageWidth: 130.0,
                        imageURL: 'assets/images/landimage0.jpg',
                        radius: 100.0,
                      ),
                    ),
                    Positioned(
                      top: 65,
                      left: -25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Container(
                          height: 70,
                          width: 50,
                          color: primaryColor,
                          child: Center(
                            child: messageText(
                              text: "now",
                              color: Colors.white,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              titleText(text: "Login Now"),
              const SizedBox(height: 15.0),
              messageText(
                color: lightTextColor,
                text: "Please enter the details below to continue",
              ),
              const SizedBox(height: 15.0),
              TextField(
                controller: emailcontroller,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 1)),
                  hintText: 'Email',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 225, 225, 225),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              TextField(
                controller: pwcontroller,
                obscureText: true,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 1),
                  ),
                  hintText: 'Password',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 225, 225, 225),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: messageText(
                      color: primaryColor, text: "Forgot Password?"),
                ),
              ),
              const SizedBox(height: 15.0),
              elevatedButton(
                text: 'LOGIN',
                function: () {
                  loginRequest(context);
                },
              ),
              const SizedBox(height: 10.0),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  messageText(color: textColor, text: "Dont have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(RoutesClass.getSingUpRoute());
                    },
                    child: messageText(color: primaryColor, text: "Create..."),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future loginRequest(context) async {
    if (emailcontroller.text.isEmpty || pwcontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text('Fields are emply!'),
        action: SnackBarAction(
          textColor: primaryColor,
          label: 'Ok',
          onPressed: () {},
        ),
      ));
    } else {
      try {
        var url = Uri.parse('$Api_url/login/');

        var body = {
          "email": emailcontroller.text,
          "password": pwcontroller.text,
        };

        emailcontroller.clear();
        pwcontroller.clear();

        var response = await http.post(url, body: body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          dynamic jsonResonse = json.decode(response.body);

          String token = jsonResonse['data']['token'];
          int id = jsonResonse['data']['user_details']['id'];
          String email = jsonResonse['data']['user_details']['email'];
          String username = jsonResonse['data']['user_details']['username'];

          upDateSharedPreferences(token, id, email, username);

          Get.toNamed(RoutesClass.getDashBoardRoute());
        } else {
          emailcontroller.clear();
          pwcontroller.clear();

          dynamic jsonResonse = json.decode(response.body);

          String message = jsonResonse['message'][0];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(message),
            action: SnackBarAction(
              textColor: primaryColor,
              label: 'Try Again',
              onPressed: () {},
            ),
          ));
        }
      } catch (error) {
        throw error; // prints the error message
      }
    }
  }
}
