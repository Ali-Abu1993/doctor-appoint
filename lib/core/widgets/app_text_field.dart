import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

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

   const CustomTextField({
    super.key,
    required this.hintText,
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
        constraints: BoxConstraints(minHeight: 48, maxWidth: 350),
        hintText: hintText,
        fillColor: mainColor,
        hintStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: Colors.grey,
          fontFamily: "Inter",
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey): null,
        prefixIconConstraints:prefixIcon !=null ? BoxConstraints(maxWidth: 50,minWidth: 40):
        BoxConstraints(maxWidth: 10),
        suffixIcon: suffixIcon,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorsManager.white)
        ),
        enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(12),
         borderSide: BorderSide(color: Colors.white54)
       ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorsManager.primary)
        ),

        contentPadding: const EdgeInsetsGeometry.only(left: 10),
      ),
    );

  }
}
