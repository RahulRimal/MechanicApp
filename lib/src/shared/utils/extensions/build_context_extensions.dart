import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get mounted {
    try {
      widget;
      return true;
    } catch (e) {
      return false;
    }
  }
}
