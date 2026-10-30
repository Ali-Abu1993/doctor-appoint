import 'package:doctor_appointment/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';


 Widget buildSectionTitle(String subTitle,[TextStyle? style,BuildContext? context]  ) {
      return Padding(
        padding: const EdgeInsets.only(right: 4, bottom: 8),
        child: Text(
            subTitle,
            style: style??  TextStyle(
              fontSize: 11,fontWeight: FontWeight.bold, color: context?.colorTheme.secondary
            )
        )
      );
    }


