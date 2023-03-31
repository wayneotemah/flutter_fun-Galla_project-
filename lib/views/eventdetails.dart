import 'package:ff_project/config.dart';
import 'package:ff_project/models/events.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'components/buttons.dart';
import 'components/texts.dart';

class EventDetails extends StatelessWidget {
  EventDetails({super.key});

  var eventDetails = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Organizer organizer1 = eventDetails[8]['organizer'][0];
    var _date = eventDetails[4]['date'];
    print(organizer1.username);
    return Scaffold(
      appBar: AppBar(
        title: Text(eventDetails[0]['eventname'].toString()),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image(
                        image:
                            NetworkImage(eventDetails[1]['image'].toString())),
                  ),
                ),
                Column(
                  children: [
                    titleText(text: eventDetails[0]['eventname'].toString()),
                    TextButton(
                      onPressed: () {},
                      child: messageText(
                          text: organizer1.username,
                          color: primaryColor,
                          weight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText(text: 'About this event', size: 16.0),
                          const SizedBox(height: 20),
                          messageText(
                            text: eventDetails[2]['details'].toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText(text: 'When and where', size: 16.0),
                          const SizedBox(height: 20),
                          Row(
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
                                    color: lightprimaryColor),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: const Center(
                                      child: Icon(
                                    Icons.calendar_month,
                                    size: 35,
                                    color: primaryColor,
                                  )),
                                ),
                              ),
                              const SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleText(text: 'Date and time', size: 16.0),
                                  const SizedBox(height: 10),
                                  messageText(
                                      text: DateFormat('EEEE, d MMMM y')
                                          .format(_date),
                                      color: lightTextColor,
                                      weight: FontWeight.bold),
                                  const SizedBox(height: 6),
                                  messageText(
                                      text: eventDetails[5]['time'].toString(),
                                      color: lightTextColor,
                                      weight: FontWeight.bold),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
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
                                    color: lightprimaryColor),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: const Center(
                                      child: Icon(
                                    Icons.location_on,
                                    size: 35,
                                    color: primaryColor,
                                  )),
                                ),
                              ),
                              const SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleText(text: 'Loaction', size: 16.0),
                                  const SizedBox(height: 10),
                                  messageText(
                                    text:
                                        eventDetails[3]['location'].toString(),
                                    color: lightTextColor,
                                    weight: FontWeight.bold,
                                  ),
                                  const SizedBox(height: 6),
                                  messageText(
                                    text: eventDetails[7]['inperson']
                                        ? "This is an inperson event"
                                        : "This is an online event",
                                    color: lightTextColor,
                                    weight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                elevatedButton(
                  text: 'Reserve',
                  sizeWidth: double.infinity,
                  sizeHeight: 50.0,
                  radius: 15.0,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
