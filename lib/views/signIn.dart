import 'package:ff_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config.dart';
import 'components/buttons.dart';
import 'components/curvedimages.dart';
import 'components/texts.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
}
