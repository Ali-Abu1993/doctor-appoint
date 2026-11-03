import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_button.dart';
import 'package:doctor_appointment/features/alldoctors/logic/all_doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../routing/routes.dart';
import '../utils/app_extensions.dart';


class DoctorCard extends StatefulWidget {
  const DoctorCard({
    super.key,
   required this.photo,
    required this.doctorName,
    required this.speciality,
    required this.address,
    this.appointPrice,
    required this.isAvailable,
    this.doctorData,
    required this.doctorIndex
  });

  final String photo;
  final String doctorName;
  final String speciality;
  final String address;
  final int? appointPrice;
  final int doctorIndex;

  final bool isAvailable;
  final dynamic doctorData;

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  bool isClicked= false;

  @override
  Widget build(BuildContext context) {
   final isDarkMode= context.isDark;
   final local=context.l1on;
    return BlocProvider(
      create: (context) => AllDoctorCubit(),
      child: Card(
        elevation: 0,
        // مفيش ضل ثقيل زي الصورة
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color:isDarkMode? Colors.grey.shade800: Colors.grey.shade300,
            width: 1.w,
          ), // الإطار الخارجي الخفيف
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- الجزء العلوي (الصورة + الـ Tag والتقييم) ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // صورة الطبيب المستديرة
                  CircleAvatar(
                    radius: 40.r,
                    backgroundImage: AssetImage(widget.photo),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(50),
                      child:Transform.scale(
                        scale: 1,


                                ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // الـ Tag والتقييم مرتبين رأسياً
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // تاق Available Today
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: widget.isAvailable ? (isDarkMode?
                                 const Color.fromRGBO(121, 242, 240, 0.3):
                                 const Color.fromRGBO(121, 242, 240, 0.10)
                            ) :  const Color.fromRGBO(255, 127, 127, 1),

                            // لون خلفية لبني خفيف جداً
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8.w,
                                height: 8.h,
                                decoration: BoxDecoration(
                                  color: widget.isAvailable
                                      ? Color.fromRGBO(0, 106, 104, 1)
                                      : Colors.redAccent,
                                  // نقطة خضراء غامقة
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.isAvailable
                                    ? local.available_today
                                    : local.not_available_today,
                                style: TextStyle(
                                  color: widget.isAvailable
                                      ? (isDarkMode?Color.fromRGBO(0, 106, 104, 1):
                                  Colors.tealAccent
                                  )
                                      : Colors.white70,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // التقييم والريفيو
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "4.9",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: isDarkMode? Colors.black: Colors.white70,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              local.reviews_format("124"),
                              style: TextStyle(
                                color:isDarkMode?  Colors.grey.shade600:Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // --- معلومات الطبيب ---
              Text(
                widget.doctorName,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color:isDarkMode?  Colors.black: Colors.white70,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.speciality,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: isDarkMode? Color.fromRGBO(0, 71, 141, 1): Colors.blue.shade200, // لون التخصص الأزرق
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),

              // مكان العيادة والمسافة
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18.sp,
                    color: isDarkMode?Colors.grey.shade600:Colors.white70,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.address,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // السعر
              Row(
                children: [
                  Icon(
                    Icons.payments_outlined,
                    size: 18,
                    color: isDarkMode? Colors.grey.shade600: Colors.white70,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.appointPrice.toString(),
                    style: TextStyle(color:
                    isDarkMode? Colors.grey.shade700: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // الخط الفاصل الخفيف
              Divider(color:isDarkMode? Colors.grey.shade200: Colors.grey.shade800, height: 1),
              const SizedBox(height: 16),

              // --- الأزرار السفلية ---
              Row(
                children: [
                  // زرار القلب (المفضلة)
                  Container(
                    decoration: BoxDecoration(
                     color: isDarkMode ? Colors.grey.shade100:Colors.grey.shade800 ,
                      border: BoxBorder.all(color:isDarkMode? Colors.grey.shade300:
                      Colors.white70),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon:  Icon(
                        isClicked? Icons.favorite:Icons.favorite_border ,
                        size: 40,
                        color: isClicked? Colors.redAccent:Colors.grey.shade300 ),
                      onPressed: () {
                        setState(() {
                          isClicked=!isClicked;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // زرار View Profile
                  Expanded(
                    child: AppButton(
                      barWidth: 141.w,
                      txt: local.view_profile,
                      onPress: () {
                        context.pushNamed(AppRouter.kDoctorDetailScreen,
                            extra: widget.doctorIndex);
                      },
                      buttonColor: isDarkMode ?   Colors.white:const Color(0xFF1F1F1F),
                      buttonTxtStyle: isDarkMode? TxtStyle.font14W700:TextStyle(
                        color: Colors.white70,
                        fontSize: 14, fontWeight: FontWeight.w700
                      ),
                      borderColor: isDarkMode? Color.fromRGBO(0, 106, 104, 0.3): Colors.white54,
                      borderWidth: 2,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // زرار Book Now
         Expanded(
    child: AppButton(
    barWidth: 124.w,
        txt: local.book_now,
        onPress: () {
          context.pushNamed(AppRouter.kDoctorDetailScreen,
              extra: widget.doctorIndex);
    },
    ),
    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
