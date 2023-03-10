import 'package:flutter/material.dart';

import '../../config.dart';

ElevatedButton elevatedButton(
    {sizeHeight = 60.0, sizeWidth = 400.0, text, color = primaryColor}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        minimumSize: Size(sizeWidth, sizeHeight)),
    onPressed: () {},
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  );
}
