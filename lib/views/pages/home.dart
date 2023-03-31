import 'dart:convert';

import 'package:ff_project/config.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/events.dart';
import '../../routes/routes.dart';
import '../components/texts.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getEvents(),
      builder: (context, data) {
        if (data.hasData) {
          return ListView.builder(
              itemCount: data.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: GestureDetector(
                          child: Image(
                            image: NetworkImage(
                              data.data![index].imageUrl,
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(RoutesClass.getEventDetails(),
                                arguments: [
                                  {"eventname": data.data![index].eventName},
                                  {"image": data.data![index].imageUrl},
                                  {"details": data.data![index].discription},
                                  {"location": data.data![index].location},
                                  {"date": data.data![index].date},
                                  {"time": data.data![index].time},
                                  {"duration": data.data![index].duration},
                                  {"inperson": data.data![index].inperson},
                                  {"organizer": data.data![index].organizer},
                                ]);
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          margin: const EdgeInsets.all(0.0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 200.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      titleText(
                                          text: data.data![index].eventName,
                                          size: 20.0),
                                      const SizedBox(height: 6),
                                      messageText(
                                        text: DateFormat('EEEE, d MMMM y')
                                            .format(data.data![index].date),
                                        color: lightTextColor,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  color: midprimaryColor,
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite),
                                ),
                                IconButton(
                                  color: midprimaryColor,
                                  onPressed: () {},
                                  icon: const Icon(Icons.bookmark),
                                ),
                                IconButton(
                                  color: midprimaryColor,
                                  onPressed: () {},
                                  icon: const Icon(Icons.share),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        endIndent: 10,
                        indent: 10,
                        thickness: 1.0,
                      )
                    ],
                  ),
                );
              });
        } else if (data.hasError) {
          return Center(
            child: Text('error ${data.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: primaryColor,
            ),
          );
        }
      },
    );
  }

  Future<List<Event>> getEvents() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _token = (_prefs.getString('token') ?? '');
    var headersList = {'Accept': '*/*', 'Authorization': 'token $_token'};
    var response = await http.get(Uri.parse("$Api_url/gallary/event/"),
        headers: headersList);
    if (response.statusCode == 200) {
      List jsonResonse = json.decode(response.body);
      return jsonResonse.map((event) => Event.fromJson(event)).toList();
    } else {
      print(response.reasonPhrase);
      throw "Error reading url";
    }
  }
}
