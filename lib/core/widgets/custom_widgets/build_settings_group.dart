import 'package:flutter/material.dart';

import '../../utils/colors_manager.dart';
import '../../utils/text_style.dart';
 const Color primaryBlue = ColorsManager.primary;
 const Color lightBlueBg = Color(0xFFE3F2FD);
Widget buildSettingsGroup(List<Widget> children) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(children: children),
  );
}

Widget buildListTile({
  required IconData icon,
  required String title,
  String? subtitle,
  String? trailingText,
  required VoidCallback onTap,
}) {

  return ListTile(
    onTap: onTap,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: lightBlueBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: primaryBlue, size: 22),
    ),
    title: Text(
      title,
      style:  TxtStyle.font15W600Black,
    ),
    subtitle: subtitle != null
        ? Text(subtitle, style: TxtStyle.font12NormalGrey)
        : null,
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (trailingText != null)
          Text(
            trailingText,
            style: TxtStyle.font14BoldBlue
          ),
        const SizedBox(width: 4),
        const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
      ],
    ),
  );
}
Widget buildSwitchTile({
  required IconData icon,
  required String title,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return ListTile(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: lightBlueBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: primaryBlue, size: 22),
    ),
    title: Text(
        title,
        style: TxtStyle.font15W600Black),
    trailing: Switch.adaptive(
      value: value,
      activeColor: primaryBlue,
      onChanged: onChanged,
    ),
  );
}
