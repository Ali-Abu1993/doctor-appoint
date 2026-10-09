import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:flutter/material.dart';

import '../utils/colors_manager.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}
int selectedDateIndex=0;
class _CalendarState extends State<Calendar> {
  String getDayName(DateTime date){
List<String> weekdays=["Mon","Tues","Wed","Thurs","Fri","Sat","Sun"];
return weekdays[date.weekday-1];
  }
  @override
  Widget build(BuildContext context) {
    return
          SizedBox(
            height: 90,
            child: ListView.builder(scrollDirection: Axis.horizontal,
                itemCount: 30,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index){
              DateTime targetDate =DateTime.now().add(Duration(days: index));
             String dayName= getDayName(targetDate);
             String dayNumber=targetDate.day.toString();
                  bool isSelected=index==selectedDateIndex;
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedDateIndex=index;
                      });
                    },
                      child: Container(
                        margin:  EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        width:72,
                        height: 88,
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(12),
                            color: isSelected? ColorsManager.primary: Color.fromRGBO(194, 198, 212, 0.5)
                        ),
                        child: Center(
                          child: Text("$dayName\n\t\t$dayNumber",
                            style: TxtStyle.font14RegularBlue.copyWith(
                            color: isSelected? ColorsManager.white  :Colors.black,
                          ),),
                        ),
                      ),

                  );

                }),
          );


  }
}
