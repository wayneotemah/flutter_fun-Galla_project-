import 'dart:math';

import 'package:ff_project/config.dart';
import 'package:flutter/material.dart';

import '../components/collections.dart';
import '../components/texts.dart';

Random random = Random();
int randomNumber = random.nextInt(100);

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
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0.0,
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: [1, 2, 3, 4, 5, 6, 7] //repplace with funtion the gets data array and pases it to the object
            .map((catData) => Collection(
                  color: lightTextColor,
                  title: 'Fav',
                  id: catData.toString(),
                ))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }
}
