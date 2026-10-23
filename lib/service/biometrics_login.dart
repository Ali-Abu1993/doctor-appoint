import 'package:flutter_launcher_icons/constants.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsService{
  final LocalAuthentication local = LocalAuthentication();
  // 1. التحقق مما إذا كان الجهاز يدعم البصمة أو ميزة التعرف على الوجه
  Future<bool> isBiometricAvailable()async {
    try {
      final bool canAuthenticateBiometrics = await local.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateBiometrics ||await local.isDeviceSupported();
      return canAuthenticate;
    } catch (e) {
      print('Error Checking Biometrics: $e');
      return false;

    }
  }
  // 2. تشغيل النافذة  لطلب البصمة من المستخدم
  Future <bool> authenticateWithBiometric()async{
    try{
    final isAvailable = await isBiometricAvailable();
     if(!isAvailable) return false;
     return await local.authenticate(localizedReason: 'Please authenticate toi access your medical account'
       ,biometricOnly: true
     );
    }catch(e){
      print("Biometric Authentication Error: $e");
      return false;

    }

  }
}