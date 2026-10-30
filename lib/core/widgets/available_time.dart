import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:flutter/material.dart';

import '../utils/colors_manager.dart';

class AvailableTime extends StatefulWidget {
  const AvailableTime({super.key,required this.timeSlots, this.onTimeSelected, this.selectedTime});
final List timeSlots;
final String? selectedTime;
final void Function(String time)? onTimeSelected;
  @override
  State<AvailableTime> createState() => _AvailableTimeState();
}

class _AvailableTimeState extends State<AvailableTime> {
  // int selectedTimeIndex=-1;
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
          final currentSlotTime = widget.timeSlots[index].toString();
          bool isSelected=currentSlotTime==widget.selectedTime;
          bool isDisabled = index==2;

          bool isAnySelected= widget.selectedTime!=null;
          bool isGreyedOut = isAnySelected && !isSelected;

          return  InkWell(
            onTap:(isDisabled)? null :(){

              if(widget.onTimeSelected != null){
                widget.onTimeSelected!(currentSlotTime);
              }

            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),

              decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(8),
                  border: BoxBorder.all(
                    color: (isDisabled || isGreyedOut)? Colors.grey.shade300:
                    (isSelected? Color.fromRGBO(0, 94, 184, 0.1): ColorsManager.white)
                  ),
                  color:(isDisabled || isGreyedOut)? Colors.grey.shade200:
                  (isSelected? Color.fromRGBO(0, 94, 184, 0.1): ColorsManager.white)
              ),
              child: Center(
                child: Text(currentSlotTime,
                  style: (isDisabled || isGreyedOut)? TextStyle(
                    color: Colors.grey.shade500,
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
