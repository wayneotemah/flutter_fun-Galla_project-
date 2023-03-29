import 'package:flutter/material.dart';

import '../components/collectionTile.dart';
import '../components/texts.dart';

class Events extends StatelessWidget {
  const Events({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleText(text: 'Reserved'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CollectionTile(),
            CollectionTile(),
            CollectionTile(),
            CollectionTile(),
            CollectionTile(),
            CollectionTile(),
            CollectionTile(),
            CollectionTile(),
            CollectionTile(),
            CollectionTile(),
            CollectionTile(),
            CollectionTile(),
            CollectionTile(),
          ],
        ),
      ),
    );
  }
}
