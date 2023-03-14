import 'dart:convert';

import 'package:ff_project/config.dart';
import 'package:ff_project/models/album.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAlbum(),
      builder: (context, data) {
        if (data.hasData) {
          return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(data.data![index].title),
                    Image.network(data.data![index].image),
                  ],
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

  Future<List<Album>> getAlbum() async {
    var response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    // var images = await http
    //     .get(Uri.parse("https://picsum.photos/v2/list?page=1&limit=200"));
    if (response.statusCode == 200) {
      List jsonResonse = json.decode(response.body);
      return jsonResonse.map((album) => Album.fromJson(album)).toList();
    } else {
      throw "Error reading url";
    }
  }
}
