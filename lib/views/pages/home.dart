import 'dart:convert';

import 'package:ff_project/config.dart';
import 'package:ff_project/models/album.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/texts.dart';

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
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText(text: data.data![index].author, size: 20.0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image(
                          image: NetworkImage(
                            data.data![index].image,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            color: primaryColor,
                            onPressed: () {},
                            icon: Icon(Icons.favorite),
                          ),
                          IconButton(
                            color: primaryColor,
                            onPressed: () {},
                            icon: Icon(Icons.comment),
                          ),
                          IconButton(
                            color: primaryColor,
                            onPressed: () {},
                            icon: Icon(Icons.share),
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
