import 'package:flutter/material.dart';

class ColorModel {
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final Color activeBackgroundColor;
  final Color inactiveBackgroundColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color selectedPageButtonBackgroundColor;
  final Color pageButtonBackgroundColor;
  final Color selectedPageButtonBorderColor;
  final Color pageButtonBorderColor;
  final Color selectedPageButtonTextColor;
  final Color pageButtonTextColor;

  const ColorModel({
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
    required this.activeBackgroundColor,
    required this.inactiveBackgroundColor,
    required this.activeIconColor,
    required this.inactiveIconColor,
    required this.selectedPageButtonBackgroundColor,
    required this.pageButtonBackgroundColor,
    required this.selectedPageButtonBorderColor,
    required this.pageButtonBorderColor,
    required this.selectedPageButtonTextColor,
    required this.pageButtonTextColor,
  });
}
