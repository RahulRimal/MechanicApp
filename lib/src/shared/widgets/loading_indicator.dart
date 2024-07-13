import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget LoadingInidicator(BuildContext context, {double? radius}) {
  return Center(
      child: SizedBox(
    height: radius,
    width: radius,
    child: CircularProgressIndicator(
      color: Theme.of(context).primaryColor,
    ),
  ));
}
