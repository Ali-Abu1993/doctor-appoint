import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

import '../utils/text_style.dart';

class AppButton extends StatelessWidget {
 final  double barWidth;
 final String txt;
 final  VoidCallback onPress;
 final Color buttonColor;
 final Color borderColor;
 final double borderWidth;
 final TextStyle buttonTxtStyle;
 final Widget? icon;
  const AppButton({super.key, required this.barWidth, required this.txt, required this.onPress,
  this.buttonColor=ColorsManager.primary, this.borderColor=ColorsManager.primary,
  this.borderWidth=0, this.buttonTxtStyle=TxtStyle.appButtonText, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPress();
      },
      child: Container(
        height:49,
        width: barWidth,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12),
          border: BoxBorder.all(
            width: borderWidth,
            color: borderColor
          )
        ),
        child: Row(
          spacing: 5,
          children: [Text(txt,style: buttonTxtStyle),icon??Text("")],
        ),
      ),
    );
  }
}
