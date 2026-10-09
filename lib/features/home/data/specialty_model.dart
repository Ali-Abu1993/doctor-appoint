import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecialtyModel {
  final String title;
  final Widget icon;

  final Color backgroundColor;
  final Color iconBackgroundColor;

  SpecialtyModel({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.iconBackgroundColor,
  });
}
