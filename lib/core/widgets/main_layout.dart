import 'package:doctor_appointment/core/utils/app_extensions.dart';
import 'package:doctor_appointment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routing/routes.dart';
import '../utils/colors_manager.dart';
import '../utils/text_style.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  int calculateSelectedIndex (BuildContext context){
 final location =GoRouterState.of(context).uri.path;
 if (location.startsWith('/home'))return 0;
 if (location.startsWith('/search'))return 1;
 if (location.startsWith('/all_doctors'))return 2;
 if (location.startsWith('/profile'))return 3;
 return 0;
  }

  @override
  Widget build(BuildContext context) {
   final local = context.l1on;
   final isDark = context.isDark;
    return
       BottomNavigationBar(
        selectedItemColor: isDark? Colors.blue[200]:ColorsManager.secondary,
        backgroundColor: isDark? ColorsManager.white: Colors.black38,

        unselectedItemColor: isDark?  ColorsManager.unselectedIcon:Colors.white70,
        unselectedLabelStyle: TxtStyle.font12W500,
        currentIndex: calculateSelectedIndex(context),
        onTap: (val) {
          if (val == 0) {
            context.pushNamed(AppRouter.kHomeScreen);
          } else if (val ==1){
            context.pushNamed(AppRouter.kSearchScreen);
          }else if (val ==2){
            context.pushNamed(AppRouter.kAllDoctorScreen);
          }
          else if (val == 3) {
            context.pushNamed(AppRouter.kProfileScreen);
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: local.home_icon,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: local.search_icon,
            backgroundColor: ColorsManager.unselectedIcon,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: local.booking_icon,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: local.profile_title,
          ),
        ],
      );

  }
}
