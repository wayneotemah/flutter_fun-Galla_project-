import 'dart:convert';

import 'package:ff_project/config.dart';
import 'package:ff_project/models/album.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/events.dart';
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
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText(text: data.data![index].eventName, size: 20.0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image(
                          image: NetworkImage(
                            data.data![index].imageUrl,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            color: primaryColor,
                            onPressed: () {},
                            icon: const Icon(Icons.favorite),
                          ),
                          IconButton(
                            color: primaryColor,
                            onPressed: () {},
                            icon: const Icon(Icons.comment),
                          ),
                          IconButton(
                            color: primaryColor,
                            onPressed: () {},
                            icon: const Icon(Icons.share),
                          )
                        ],
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
