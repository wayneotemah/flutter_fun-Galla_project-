import 'package:ff_project/views/components/texts.dart';
import 'package:flutter/material.dart';

class CollectionTile extends StatelessWidget {
  const CollectionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image(
            image: NetworkImage(
                'https://fastly.picsum.photos/id/1084/200/300.jpg?hmac=JQMQbKvpN6_d6r-fiuOEYe1Dz6f2gfGIkTvsx0nLJUQ'),
          ),
        ),
        title: titleText(size: 20.0, text: "Art title"),
        subtitle: messageText(
            text:
                "Art by Morale taken in 2009, in kenya. Died in Congo and was friends with KIKI"),
      ),
    );
  }
}
