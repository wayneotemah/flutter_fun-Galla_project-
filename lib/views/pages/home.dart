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
              itemCount: data.data?.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(data.data![index].author),
                    Image.network(data.data![index].image),
                  ],
                );
              });
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
        .get(Uri.parse("https://picsum.photos/v2/list?page=2&limit=20"));
    if (response.statusCode == 200) {
      List jsonResonse = json.decode(response.body);
      return jsonResonse.map((album) => Album.fromJson(album)).toList();
    } else {
      throw "Error reading url";
    }
  }
}
