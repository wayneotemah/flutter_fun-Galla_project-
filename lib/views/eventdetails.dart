import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';

class EventDetails extends StatelessWidget {
  EventDetails({super.key});

  var eventDetails = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Text(eventDetails[0]['eventname'].toString()),
    );
  }
}
