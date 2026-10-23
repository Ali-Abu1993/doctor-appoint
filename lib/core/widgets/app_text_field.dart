import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? query;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool isPassword; // To handle password masking
  final  VoidCallback? onPress;
  final FormFieldValidator textInput;
  final Color mainColor;
  final TextStyle hintStyle;
  final Color prefixColor;
  final Color suffixColor;
  final InputDecoration? decoration;

   const CustomTextField({
    super.key,
    required this.hintText,
     this.decoration=const InputDecoration(
       disabledBorder:  OutlineInputBorder(
           borderSide:  BorderSide(color: ColorsManager.unselectedIcon)
       ),
       enabledBorder: OutlineInputBorder(
           borderSide:  BorderSide(color: ColorsManager.primary)
       ),
       focusedBorder: OutlineInputBorder(
           borderSide:  BorderSide(color: ColorsManager.primary)
       ),
     ),
     this.hintStyle= const TextStyle(
       fontWeight: FontWeight.normal,
       fontSize: 14,
       color: Colors.grey,
       fontFamily: "Inter",
     ),
     this.prefixColor= Colors.grey,
     this.suffixColor=Colors.grey,
    this.prefixIcon,
     this.query,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.onPress,
     this.mainColor=Colors.white,
    required this.textInput
  });



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: query,
      validator: textInput,
      onTap: onPress,
      keyboardType: keyboardType,
      obscureText: isPassword,

      decoration: InputDecoration(
        constraints: BoxConstraints(minHeight: 48.h, maxWidth: 350.w),
        hintText: hintText,


        fillColor: mainColor,
        hintStyle: hintStyle,
        prefixIconColor: prefixColor,
        suffixIconColor: suffixColor,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon): null,
        prefixIconConstraints:prefixIcon !=null ? BoxConstraints(maxWidth: 50,minWidth: 40):
        BoxConstraints(maxWidth: 10),
        suffixIcon: suffixIcon,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),

        ),
        enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(12),

       ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),

        ),

        contentPadding: const EdgeInsetsGeometry.only(left: 10),
      ),
    );

  }
}
