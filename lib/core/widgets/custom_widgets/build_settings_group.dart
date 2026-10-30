import 'package:doctor_appointment/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../utils/colors_manager.dart';
import '../../utils/text_style.dart';
 const Color primaryBlue = ColorsManager.primary;
 const Color lightBlueBg = Color(0xFFE3F2FD);
Widget buildSettingsGroup(List<Widget> children,[BuildContext? context]) {
  return Container(
    decoration: BoxDecoration(
      color: context?.colorTheme.secondary,
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

Widget buildListTile(BuildContext context,{
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
        color: Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: ColorsManager.primary, size: 22),
    ),
    title: Text(
      title,
      style:  TxtStyle.font15W600Black(context),
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
         Icon(Icons.arrow_forward_ios_rounded, size: 16,
            color: context.isDark? Colors.grey: Colors.white),
      ],
    ),
  );
}
Widget buildSwitchTile(BuildContext context,{
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
        color: Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: ColorsManager.primary, size: 22),
    ),
    title: Text(
        title,
        style: TxtStyle.font15W600Black(context)),
    trailing: Switch.adaptive(
      value: value,
      activeColor: ColorsManager.primary,
      onChanged: onChanged,
    ),
  );
}
