import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:flutter/material.dart';

import '../utils/colors_manager.dart';

class AvailableTime extends StatefulWidget {
  const AvailableTime({super.key,required this.timeSlots});
final List timeSlots;
  @override
  State<AvailableTime> createState() => _AvailableTimeState();
}

class _AvailableTimeState extends State<AvailableTime> {
  int selectedTimeIndex=-1;
  // bool isDisabled=true;
  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
        childAspectRatio: 2.4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        ),
        shrinkWrap: true,
        itemCount: widget.timeSlots.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          bool isSelected=index==selectedTimeIndex;
          bool isDisabled = index==2;

          return  InkWell(
            onTap:isDisabled? null :(){
              setState(() {
                selectedTimeIndex=index;
              });

            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),

              decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(8),
                  border: BoxBorder.all(
                    color: isDisabled? Colors.grey.shade50:
                    (isSelected? Color.fromRGBO(0, 94, 184, 0.1): ColorsManager.white)
                  ),
                  color:isDisabled? Colors.grey.shade50:
                  (isSelected? Color.fromRGBO(0, 94, 184, 0.1): ColorsManager.white)
              ),
              child: Center(
                child: Text(widget.timeSlots[index],
                  style: isDisabled? TextStyle(
                    color: Colors.grey.shade500,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 14
                  ):TxtStyle.font14SemiBold.copyWith(
                    color: isSelected? ColorsManager.primary: Colors.black,
                  ),),
              ),
            ),

          );
        },

      );

  }
}
