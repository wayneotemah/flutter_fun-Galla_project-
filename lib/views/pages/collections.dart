import 'dart:convert';
import 'package:ff_project/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../models/events.dart';
import '../components/collections.dart';
import '../components/texts.dart';

class Collections extends StatelessWidget {
  const Collections({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleText(text: 'My Collention'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: getColletion(),
        builder: (context, data) {
          if (data.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: data.data!.length,
              itemBuilder: (context, index) {
                return CollectionTile(
                  title: data.data![index].title.toString(),
                  number: data.data![index].number,
                  events: data.data![index].event,
                );
              },
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
              ),
            );
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
      ),
    );
  }

  Future<List<Collection>> getColletion() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _token = (_prefs.getString('token') ?? '');
    var headersList = {'Accept': '*/*', 'Authorization': 'token $_token'};
    var response = await http.get(Uri.parse("$Api_url/gallary/collection/"),
        headers: headersList);
    if (response.statusCode == 200) {
      List jsonResonse = json.decode(response.body);
      return jsonResonse
          .map((collection) => Collection.fromJson(collection))
          .toList();
    } else {
      // print(response.reasonPhrase);
      throw "Error reading url";
    }
  }
}
