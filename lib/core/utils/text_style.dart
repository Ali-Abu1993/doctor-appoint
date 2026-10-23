import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors_manager.dart';

class TxtStyle {
  static const TextStyle appButtonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static  TextStyle font14RegularBlue = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.primary,
  );
  static  TextStyle font26W700Black=  TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: 26.sp,
  );
  static  TextStyle font24W600Black = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle font18SemiBold =  TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle font14SemiBold =  TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle font16Medium =  TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle font16W400Regular =  TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(66, 71, 82, 0.8)
  );

  static TextStyle font14W700 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(0, 106, 104, 1),
  );
  static TextStyle font12W500 = TextStyle(
    color: ColorsManager.unselectedIcon,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500
  );
  static  TextStyle font20W700Blue = TextStyle(
      color: ColorsManager.primary,
      fontSize: 20.sp,
      fontWeight: FontWeight.w700
  );
  static TextStyle font11BoldGrey = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      color: Colors.grey);
  static TextStyle font15W600DarkBlue = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1E293B));
  static TextStyle font14BoldGrey =  TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
  static TextStyle font16BoldRed =  TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.redAccent,
  );
  static TextStyle font14BoldBlue =  TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: ColorsManager.primary,
  );
  static TextStyle font12NormalGrey =  TextStyle(fontSize: 12,
      color: Colors.grey);
  static TextStyle font15W600Black =  TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );


}