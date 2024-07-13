// ignore_for_file: non_constant_identifier_names

import 'package:bato_mechanic/src/shared/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

Widget ImageWidget(String image,
    {double? height, double? width, isNetwork = true}) {
  if (image.contains("googleusercontent.com")) {
    image = image.replaceAll("/media/https%3A/", "https://");
  }
  if (isNetwork) {
    if (!image.contains('http')) {
      image = HelperFunctions.getFullImageUrl(image);
    }
    if (image.contains('https://') || image.contains('http://')) {
      return Image.network(
        image,
        height: height,
        width: width,
      );
    }
  }
  return Image.asset(
    image,
    height: height,
    width: width,
    fit: BoxFit.fill,
  );
}

ImageProvider ImageWidgetProvider(String image,
    {double? height, double? width, isNetwork = true}) {
  if (image.contains("googleusercontent.com")) {
    image = image.replaceAll("/media/https%3A/", "https://");
  }
  if (isNetwork) {
    if (!image.contains('http')) {
      image = HelperFunctions.getFullImageUrl(image);
    }
    if (image.contains('https://') || image.contains('http://')) {
      return NetworkImage(
        image,
      );
    }
  }
  return AssetImage(
    image,
  );
}
