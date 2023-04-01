import 'dart:ffi';

import 'package:ff_project/views/components/texts.dart';
import 'package:flutter/material.dart';

import '../../config.dart';

String image_url =
    "https://fastly.picsum.photos/id/238/200/300.jpg?hmac=WF3u-tnO4aoQvz_F9p7zS0Dr5LwGx74tPabQf7EjHkw";

class CollectionTile extends StatelessWidget {
  final String title;
  final Color color;
  int number;
  // final String id;

  CollectionTile({
    super.key,
    required this.title,
    required this.number,
    this.color = lightprimaryColor,
  });

  void selectCategory(BuildContext ctx) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(1), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(image_url), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            titleText(
              text: title,
              size: 26.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: lightTransparentColor,
                ),
                child: Ink(
                  child: Center(
                    child: number > 0
                        ? titleText(
                            text: number.toString(), color: Colors.white)
                        : const Icon(Icons.add, size: 35),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
