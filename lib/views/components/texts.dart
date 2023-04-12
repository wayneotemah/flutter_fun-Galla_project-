import 'package:flutter/material.dart';

Text titleText({size = 30.0, text, color = Colors.black}) {
  return Text(
    text,
    // maxLines: 2,
    overflow: TextOverflow.fade,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color,
      fontFamily: 'Poppins',
    ),
  );
}

Text messageText({color, text, weight = FontWeight.normal}) {
  return Text(
    text,
    maxLines: 5,
    overflow: TextOverflow.fade,
    style: TextStyle(color: color, fontWeight: weight, fontFamily: 'Poppins'),
  );
}
