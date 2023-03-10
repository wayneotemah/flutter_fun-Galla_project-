
  import 'package:flutter/material.dart';

ClipRRect carvedEdgeImage({imageHeight, imageWidth, radius: 0.0, imageURL}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        height: imageHeight,
        width: imageWidth,
        child: Image.asset(
          imageURL,
          fit: BoxFit.fill,
        ),
      ),
    );
  }