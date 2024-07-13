import 'package:bato_mechanic/src/shared/utils/constants/managers/font_manager.dart';
import 'package:flutter/material.dart';

import '../../constants/managers/color_manager.dart';

/// Custom Class for Light & Dark Text Themes
class BaatoTextTheme {
  BaatoTextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(
      fontSize: FontSize.s28,
      fontWeight: FontWeight.bold,
      color: ThemeColor.dark,
    ),
    displayMedium: const TextStyle().copyWith(
      fontSize: FontSize.s24,
      fontWeight: FontWeight.bold,
      color: ThemeColor.dark,
    ),
    displaySmall: const TextStyle().copyWith(
      fontSize: FontSize.s20,
      fontWeight: FontWeight.bold,
      color: ThemeColor.dark,
    ),
    headlineLarge: const TextStyle().copyWith(
      fontSize: FontSize.s18,
      fontWeight: FontWeight.bold,
      color: ThemeColor.dark,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w600,
      color: ThemeColor.dark,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
      color: ThemeColor.dark,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w600,
      color: ThemeColor.dark,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w500,
      color: ThemeColor.dark,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w400,
      color: ThemeColor.dark,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w500,
      color: ThemeColor.dark,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.normal,
      color: ThemeColor.dark,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w500,
      color: ThemeColor.dark.withOpacity(0.5),
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.bold,
      color: ThemeColor.dark,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.normal,
      color: ThemeColor.dark.withOpacity(0.5),
    ),
    labelSmall: const TextStyle().copyWith(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.w300,
      color: ThemeColor.dark.withOpacity(0.5),
    ),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(
      fontSize: FontSize.s28,
      fontWeight: FontWeight.bold,
      color: ThemeColor.light,
    ),
    displayMedium: const TextStyle().copyWith(
      fontSize: FontSize.s24,
      fontWeight: FontWeight.bold,
      color: ThemeColor.light,
    ),
    displaySmall: const TextStyle().copyWith(
      fontSize: FontSize.s20,
      fontWeight: FontWeight.bold,
      color: ThemeColor.light,
    ),
    headlineLarge: const TextStyle().copyWith(
      fontSize: FontSize.s18,
      fontWeight: FontWeight.bold,
      color: ThemeColor.light,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w600,
      color: ThemeColor.light,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
      color: ThemeColor.light,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w600,
      color: ThemeColor.light,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w500,
      color: ThemeColor.light,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w400,
      color: ThemeColor.light,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w500,
      color: ThemeColor.light,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.normal,
      color: ThemeColor.light,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w500,
      color: ThemeColor.light.withOpacity(0.5),
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.bold,
      color: ThemeColor.light,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.normal,
      color: ThemeColor.light.withOpacity(0.5),
    ),
    labelSmall: const TextStyle().copyWith(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.w300,
      color: ThemeColor.light.withOpacity(0.5),
    ),
  );
}
