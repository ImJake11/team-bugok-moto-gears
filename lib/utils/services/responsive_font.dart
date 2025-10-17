import 'package:flutter/material.dart';

double responsiveFontSize(BuildContext context, double baseSize) {
  final width = MediaQuery.of(context).size.width;
  if (width > 1500) return baseSize * 2.2;
  if (width > 1200) return baseSize * 1.6; // Desktop
  if (width > 600) return baseSize * 1.3; // Tablet
  return baseSize; // Mobile
}
