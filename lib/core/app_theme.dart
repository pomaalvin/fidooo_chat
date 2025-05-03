import 'package:fidooo_chat/shared/styles/color_styles.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  cardColor: Colors.white,
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: AppColorStyles.lightGrey50),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColorStyles.primary,
      onPrimary: AppColorStyles.primary,
      secondary: AppColorStyles.secondary,
      onSecondary: AppColorStyles.secondary,
      error: AppColorStyles.error,
      onError: AppColorStyles.error,
      surface: AppColorStyles.lightGrey35,
      onSurface: AppColorStyles.dark
  )
);