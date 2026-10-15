import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_button.dart';
import 'package:doctor_appointment/features/alldoctors/logic/all_doctor_cubit.dart';
import 'package:doctor_appointment/features/doctor_details/presentation/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DoctorCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllDoctorCubit(),
      child: Card(
        elevation: 0,
        // مفيش ضل ثقيل زي الصورة
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Colors.grey.shade300,
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
                    backgroundImage: AssetImage(photo),
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
                            color: isAvailable
                                ? Color.fromRGBO(121, 242, 240, 0.3)
                                : Color.fromRGBO(255, 127, 127, 1),
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
                                  color: isAvailable
                                      ? Color.fromRGBO(0, 106, 104, 1)
                                      : Colors.redAccent,
                                  // نقطة خضراء غامقة
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                isAvailable
                                    ? "Available Today"
                                    : "Not Available Today",
                                style: TextStyle(
                                  color: isAvailable
                                      ? Color.fromRGBO(0, 106, 104, 1)
                                      : Colors.white54,
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
                            const Text(
                              "4.9",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "(124 reviews)",
                              style: TextStyle(
                                color: Colors.grey.shade600,
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
                doctorName,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                speciality,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Color.fromRGBO(0, 71, 141, 1), // لون التخصص الأزرق
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
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    address,
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
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    appointPrice.toString(),
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // الخط الفاصل الخفيف
              Divider(color: Colors.grey.shade200, height: 1),
              const SizedBox(height: 16),

              // --- الأزرار السفلية ---
              Row(
                children: [
                  // زرار القلب (المفضلة)
                  Container(
                    decoration: BoxDecoration(
                      border: BoxBorder.all(color: Colors.grey.shade300),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Color(0xff0B1A30),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  // زرار View Profile
                  Expanded(
                    child: AppButton(
                      barWidth: 141,
                      txt: "View Profile",
                      onPress: () {},
                      buttonColor: Colors.white,
                      buttonTxtStyle: TxtStyle.font14W700,
                      borderColor: Color.fromRGBO(0, 106, 104, 0.3),
                      borderWidth: 2,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // زرار Book Now
         Expanded(
    child: AppButton(
    barWidth: 124,
        txt: "Book Now",
        onPress: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorDetails(
            docImage: photo,
            docName: doctorName,
            docDescription:
            doctorData.description ?? "",
            docExperience: doctorData.degree ?? "",
            docSpeciality:
            doctorData.specialization.name ?? "",
            docEmail: doctorData.email ?? "",
            docPhoneNumber: doctorData.phone ?? "",
            startTime: doctorData.startTime ?? "",
              endTime: doctorData.endTime ?? "",
            doctorAddress: doctorData.address ?? "",doctorIndex: doctorIndex,

          ),
        ),
      );
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
