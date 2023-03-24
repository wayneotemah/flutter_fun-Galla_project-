import 'package:flutter/material.dart';

import '../../config.dart';

ElevatedButton elevatedButton(
    {sizeHeight = 60.0,
    sizeWidth = 400.0,
    text,
    color = primaryColor,
    function = functionholder}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        minimumSize: Size(sizeWidth, sizeHeight)),
    onPressed: function,
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  );
}

functionholder() {
  print("this is button funtion place holder, implement the funtion  ");
}
