import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../config.dart';
import '../routes/routes.dart';
import 'components/buttons.dart';
import 'components/texts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/logo.svg',
                width: 200,
                height: 200,
              ),
              titleText(text: "GALLA", size: 40.0),
              const SizedBox(height: 20.0),
              titleText(text: "Create Account"),
              const SizedBox(height: 15.0),
              messageText(
                color: lightTextColor,
                text: "Please enter the details below to create account",
              ),
              const SizedBox(height: 15.0),
              TextField(
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 1)),
                  hintText: 'Username',
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
              const SizedBox(height: 15.0),
              elevatedButton(
                text: 'Create and Login',
              ),
              const SizedBox(height: 10.0),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  messageText(
                      color: textColor, text: "Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(
                        RoutesClass.getLoginRoute(),
                      );
                    },
                    child: messageText(color: primaryColor, text: "Login"),
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
