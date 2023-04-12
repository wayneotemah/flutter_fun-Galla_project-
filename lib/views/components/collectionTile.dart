import 'package:ff_project/views/components/texts.dart';
import 'package:flutter/material.dart';

class CollectionTile extends StatelessWidget {
  CollectionTile({
    super.key,
    required this.image_url,
    required this.title,
    required this.description,
  });

  final String image_url;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image(
            width: 60.0,
            height: 100,
            image: NetworkImage(image_url),
            fit: BoxFit.cover,
          ),
        ),
        title: titleText(size: 20.0, text: title),
        subtitle: messageText(text: description, maxLines: 2),
      ),
    );
  }
}
