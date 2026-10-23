import 'package:firebase_messaging/firebase_messaging.dart';

class RequestPermission {
static Future<void> requestPermission() async {
    FirebaseMessaging message = FirebaseMessaging.instance;
   NotificationSettings settings =await message.requestPermission(
      alert: true,badge: true , sound: true
    );
   if(settings.authorizationStatus==AuthorizationStatus.authorized){
     print('المستخدم وافق على استقبال الإشعارات');
   } else {
     print('المستخدم رفض الصلاحية');
   }
  }

}
 Future<void> getToken() async {
String? token = await FirebaseMessaging.instance.getToken();
print("FCM Token: $token");
}