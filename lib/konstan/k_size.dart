import 'package:flutter/material.dart';

class KSize {
  // Vertical spacing constants. Adjust to your liking.
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;

  static const double buttonHeight = 48.0;

  static const double edgeSmall = 4.0;
  static const double edgeMedium = 8.0;
  static const double edgeLarge = 16.0;

  static const Widget verticalSmall = SizedBox(height: small);
  static const Widget verticalMedium = SizedBox(height: medium);
  static const Widget verticalLarge = SizedBox(height: large);

  static const Widget horizontalSmall = SizedBox(width: small);
  static const Widget horizontalMedium = SizedBox(width: medium);
  static const Widget horizontalLarge = SizedBox(width: large);
}
