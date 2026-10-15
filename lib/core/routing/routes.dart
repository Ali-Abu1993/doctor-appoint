
import 'package:doctor_appointment/core/widgets/search_widget.dart';
import 'package:doctor_appointment/features/alldoctors/presentation/all_doctors_screen.dart';
import 'package:doctor_appointment/features/auth/presentation/login_screen.dart';
import 'package:doctor_appointment/features/auth/presentation/register_screen.dart';
import 'package:doctor_appointment/features/doctor_details/presentation/doctor_details.dart';
import 'package:doctor_appointment/features/home/presentation/home_screen.dart';
import 'package:doctor_appointment/features/user_edit_profile/data/user_profile_model.dart';
import 'package:doctor_appointment/features/user_edit_profile/presentation/edit_profile_screen.dart';
import 'package:doctor_appointment/features/user_edit_profile/presentation/user_profile.dart';
import 'package:go_router/go_router.dart';


abstract class AppRouter {
  // تعريف أسماء المسارات كـ Constants لمنع الأخطاء الإملائية
  static const kLoginScreen = '/';
  static const kSignUpScreen = '/signup';
  static const kAllDoctorScreen = '/all_doctors';
  static const kDoctorDetailScreen = '/doctor_details';
  static const kProfileScreen = '/profile';
  static const editProfileScreen = '/edit_profile';
  static const kHomeScreen = '/home';
  static const kSearchScreen = '/search';


  static final router = GoRouter(
    initialLocation: kLoginScreen,
    routes: [GoRoute(path: kSignUpScreen,
    name : kSignUpScreen,
    builder: (context, state)=> RegisterScreen()),
      
      GoRoute(path: kSearchScreen,
      name: kSearchScreen ,
      builder: (context, state)=>SearchWidget()),
      GoRoute(path: editProfileScreen,
      name: editProfileScreen,
      builder: (context, state){
       final editProfile = state.extra as UserProfileModel?;
       return EditProfileScreen(editProfile: editProfile,);
      }), GoRoute(
        name: kHomeScreen,
        path: kHomeScreen,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: kLoginScreen,
        name: kLoginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: kProfileScreen,
        name: kProfileScreen,
        builder: (context, state) => const UserProfile(),
      ),
      GoRoute(
        path: kAllDoctorScreen,
        name: kAllDoctorScreen,

        builder: (_, state) => const AllDoctorsScreen(),
      ),
      GoRoute(
        path: kDoctorDetailScreen,
        name: kDoctorDetailScreen,

        builder: (_,state) {
          final extraData = state.extra as Map<String,dynamic>;
           return DoctorDetails(docImage: extraData['docImage'],
              docName: extraData['docName'],
              docExperience: extraData['docExperience'],
              doctorIndex: extraData['doctorIndex'],
              docDescription: extraData['docDescription'],
              docSpeciality: extraData['docSpeciality'],
              docEmail: extraData['docEmail'],
              docPhoneNumber: extraData['docPhoneNumber'],
              startTime: extraData['startTime'],
              endTime: extraData['endTime'],
              doctorAddress: extraData['doctorAddress']);
        })
    ],
  );
}
