import 'package:intl/intl.dart';

abstract class AvailableDoctors {
  static  bool checkAvailability(String? startTime , String? endTime){
    if (startTime==null || endTime==null) return false;

    try{
     final timeFormat= DateFormat("HH:mm");

      final startTimeParsed =timeFormat.parse(startTime);
      final endTimeParsed = timeFormat.parse(endTime);

      final now = DateTime.now();
      final currentTimeParsed = timeFormat.parse("${now.hour}:${now.minute}");
      return currentTimeParsed.isAfter(startTimeParsed) && currentTimeParsed.isBefore(endTimeParsed);

    }catch(e){
      return false;
    }
  }

}
 List<String> generateMorningSlots(String? apiStartTime , String? apiEndTime){
List<String> morningSlots=[];
if (apiStartTime == null || apiEndTime == null) return morningSlots;
try{
int startHour = int.parse(apiStartTime.split(":")[0]);
int startMinute = int.parse(apiStartTime.split(":")[1]);
int endHour = int.parse(apiEndTime.split(":")[0]);
// int endMinute = int.parse(apiEndTime.split(":")[1]);

int currentHour =startHour;
int currentMinute =startMinute;

while(currentHour<endHour&& currentHour<17){

if(currentHour <17){
String noon= currentHour >=12? "PM": "AM";
int displayHour =currentHour >12 ? currentHour-12:(currentHour==0?12:currentHour);
String minuteStr = currentMinute <10 ? "0$currentMinute" : "$currentMinute";
morningSlots.add("$displayHour:$minuteStr $noon");}

currentMinute += 30;
if(currentMinute>=60){
currentHour+=1;
currentMinute-=60;
}

}
}catch(error){
print("خطأ في تحويل أوقات الـ API: $error");
}
return morningSlots;
}
List<String> getEveningSlots(String? apiStartTime, String? apiEndTime){
  List<String> eveningSlots =[];
  if(apiStartTime==null || apiEndTime==null) return eveningSlots;
  try{
  int startHour = int.parse(apiStartTime.split(":")[0]);
  int startMinute = int.parse(apiStartTime.split(":")[1]);

  int endHour =int.parse(apiEndTime.split(":")[0]);
  int endMinute =int.parse(apiEndTime.split(":")[1]);

  int currentHour = startHour;
  int currentMinute = startMinute;

  while(currentHour<endHour || currentHour==endHour && currentMinute<endMinute){
    if(currentHour>=17){
      String noonConversion=currentHour>=12? "PM":"AM";
      int displayHour =currentHour>12? currentHour-12:(currentHour==0? 12:currentHour);
      String minuteConversion= currentMinute<10?"0$currentMinute":"$currentMinute";

      eveningSlots.add("$displayHour:$minuteConversion $noonConversion");
    }
    currentMinute+=30;
    if(currentMinute>=60){
      currentHour+=1;
      currentMinute-=60;
    }

  }
  }
  catch(error){
    print("خطأ في تحويل أوقات الـ API: $error");
  }
  return eveningSlots ;
}