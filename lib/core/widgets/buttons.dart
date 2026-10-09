import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
    this.logo, {
    super.key,
    required this.containerWidth,
    required this.containerHeight,
    required this.borderColor,
    required this.textColor,
    required this.body,
    required this.fontWeight,
    required this.onTap
  });
  final double containerWidth;
  final double containerHeight;
  final Color borderColor;
  final Color textColor;
  final String body;
  final FontWeight fontWeight;
  final String logo;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
          border: BoxBorder.all(color: borderColor),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(logo),
              SizedBox(width: 10),
              Text(
                body,
                style: TextStyle(
                  color: textColor,
                  fontWeight: fontWeight,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
