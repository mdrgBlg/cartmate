import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x339CA3AF), blurRadius: 50, spreadRadius: 1),
  ];

  static const List<BoxShadow> soft = [
    BoxShadow(color: Color(0x14111827), blurRadius: 12, offset: Offset(0, 4)),
  ];
}
