import 'package:doctor_appointment/features/auth/presentation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), (){if (mounted){
      Navigator.pushReplacement(context,
          PageTransition(type: PageTransitionType.bottomToTop,child: RegisterScreen()));
    }
    });

  }
  @override
  Widget build(BuildContext context) {
    // return AnimatedSplashScreen(
    //     splash: "assets/images_and_icons/anime.png",
    //     nextScreen: RegisterScreen());
    //     // splashTransition: SplashTransition.sizeTransition,
    //     // pageTransitionType: PageTransitionType.fade);
    return Scaffold(
      body: Center(child: Image.asset("assets/images_and_icons/anime.png" ))
     );
  }
}

