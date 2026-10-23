import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

Widget buildInfoTile(IconData icon, String label, String value,TextStyle valueTextStyle, TextStyle labelTextStyle) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(offset: Offset(0, 5),blurRadius: 10)]),
        child: Icon(icon, color: const Color(0xFF0D529C), size: 20),
      ),
      const SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:  labelTextStyle),
          const SizedBox(height: 2),
          Text(value, style:  valueTextStyle)
        ],
      ),
    ],
  );
}