import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../routes/routes.dart';
import 'components/buttons.dart';
import 'components/texts.dart';
import 'helper/sharedPref.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pwcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    pwcontroller.dispose();
    usernamecontroller.dispose();
  }

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
                controller: usernamecontroller,
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
              const SizedBox(height: 15.0),
              elevatedButton(
                  text: 'Sign Up',
                  function: () {
                    signUpRequest(context);
                  }),
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

  Future signUpRequest(context) async {
    if (emailcontroller.text.isEmpty ||
        pwcontroller.text.isEmpty ||
        usernamecontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text('Fill all the fileds'),
        action: SnackBarAction(
          textColor: primaryColor,
          label: 'Ok',
          onPressed: () {},
        ),
      ));
    } else {
      try {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Signing you in'),
          duration: Duration(seconds: 1),
        ));

        var url = Uri.parse('$Api_url/user/');

        var body = {
          "email": emailcontroller.text,
          "password": pwcontroller.text,
          "username": usernamecontroller.text,
        };

        emailcontroller.clear();
        pwcontroller.clear();

        var response = await http.post(url, body: body);
        if (response.statusCode == 201) {
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

          String? message = response.reasonPhrase;
          print(message);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(message!),
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
