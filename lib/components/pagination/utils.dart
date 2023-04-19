import 'package:flutter/material.dart';

getSecondaryColor(Color primaryColor) {
  return primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}
