import 'package:ff_project/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/collectionTile.dart';
import 'components/texts.dart';

String image_url =
    "https://fastly.picsum.photos/id/238/200/300.jpg?hmac=WF3u-tnO4aoQvz_F9p7zS0Dr5LwGx74tPabQf7EjHkw";

class CollectionListScreen extends StatelessWidget {
  CollectionListScreen({super.key});
  var orientation, size, height, width;

  var collection = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var items = collection[0]['events'];
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: titleText(
            text: collection[1]['title'].toString(), color: primaryColor),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: height / 5,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image(
                        // width: 200.0,
                        image: NetworkImage(image_url),
                      ),
                    ),
                  ),
                  Expanded(
                    // width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleText(
                            text:
                                "My ${collection[1]['title'].toString()} collection",
                            size: 20.0),
                        const SizedBox(
                          height: 20,
                        ),
                        messageText(
                            text:
                                "An event description is a piece of text or copy, outlining the details of your event. These details come together to create a compelling statement which will help to draw in your target audience and even gain new guests!")
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
                child: ListView.builder(
              // Let the ListView know how many items it needs to build.
              itemCount: items.length,
              // Provide a builder function. This is where the magic happens.
              // Convert each item into a widget based on the type of item it is.
              itemBuilder: (context, index) {
                final item = items[index];

                return CollectionTile(
                  image_url: item.imageUrl,
                  title: item.eventName,
                  description: item.discription,
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
