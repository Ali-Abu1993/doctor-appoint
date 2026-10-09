import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/features/home/data/specialty_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewSpeciality extends StatelessWidget {
  final List<SpecialtyModel> specialities = [
    SpecialtyModel(
      title: 'Cardiology',
      icon: Icon(Icons.favorite,color: Colors.green,),
      backgroundColor: Colors.greenAccent.shade200,
      iconBackgroundColor: Colors.lightGreen.shade500,
    ),
    SpecialtyModel(
      title: 'Dental',
      icon: Image.asset('assets/images_and_icons/teeth_icon.png',
        color: Color.fromRGBO(0, 71, 141, 1),width: 18,height: 18,),
      backgroundColor: Color.fromRGBO(0, 94, 184, 0.1),
      iconBackgroundColor: Color.fromRGBO(0, 94, 184, 0.1)
    ),
    SpecialtyModel(
      title: 'General',
      icon: Icon(Icons.health_and_safety_outlined),
      backgroundColor: Color.fromRGBO(91, 96, 99, 0.2),
      iconBackgroundColor: Color.fromRGBO(91, 96, 99, 0.2)
    ),
    SpecialtyModel(
      title: 'Endocrinology',
      icon: Icon(Icons.medical_services_outlined),
      backgroundColor: Color.fromRGBO(121, 242, 240, 0.2),
      iconBackgroundColor: Color.fromRGBO(121, 242, 240, 0.2)
    ),
  ];

  ListViewSpeciality({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(scrollDirection: Axis.horizontal,
          itemCount: specialities.length,
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context,index){
        final item =specialities[index];
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: item.backgroundColor

            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48.r,
                  backgroundColor: item.iconBackgroundColor,
                  child: item.icon,
                ),
                SizedBox(height: 10,),
                Text(item.title,style: TxtStyle.font16Medium,)

              ],
            ),
          ),

        );



          }),
    );
  }
}
