
import 'package:doctor_appointment/core/constance/api_const.dart';
import 'package:doctor_appointment/core/mock_data/data/all_doctors_mock_data.dart';
import 'package:doctor_appointment/core/widgets/change_pass_screen.dart';
import 'package:doctor_appointment/core/widgets/search_widget.dart';
import 'package:doctor_appointment/core/widgets/settings_screen.dart';
import 'package:doctor_appointment/features/alldoctors/presentation/all_doctors_screen.dart';
import 'package:doctor_appointment/features/auth/presentation/login_screen.dart';
import 'package:doctor_appointment/features/auth/presentation/register_screen.dart';
import 'package:doctor_appointment/features/doctor_details/presentation/doctor_details.dart';
import 'package:doctor_appointment/features/home/data/doctors_model.dart';
import 'package:doctor_appointment/features/home/presentation/home_screen.dart';
import 'package:doctor_appointment/features/splash/splash_screen.dart';
import 'package:doctor_appointment/features/user_edit_profile/data/user_profile_model.dart';
import 'package:doctor_appointment/features/user_edit_profile/presentation/edit_profile_screen.dart';
import 'package:doctor_appointment/features/user_edit_profile/presentation/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


abstract class AppRouter {
  // تعريف أسماء المسارات كـ Constants لمنع الأخطاء الإملائية
  static const kLoginScreen = '/';
  static const kSplashScreen = '/splash';
  static const kSignUpScreen = '/signup';
  static const kAllDoctorScreen = '/all_doctors';
  static const kDoctorDetailScreen = '/doctor_details';
  static const kProfileScreen = '/profile';
  static const editProfileScreen = '/edit_profile';
  static const kHomeScreen = '/home';
  static const kSearchScreen = '/search';
  static const kSettingsScreen = '/settings';
  static const kChangePassScreen = '/Change_password';


  static final router = GoRouter(
    initialLocation: kSplashScreen,
    routes: [
      GoRoute(path:kSplashScreen,
        name: kSplashScreen,
      builder: (state,context)=>SplashScreen()),

      GoRoute(path: kSignUpScreen,
    name : kSignUpScreen,
    builder: (context, state)=> RegisterScreen()),
      GoRoute(name:kSettingsScreen ,
          path: kSettingsScreen,
      builder: (context, state)=> const SettingsScreen()),
      GoRoute(name: kChangePassScreen,
          path: kChangePassScreen,
       builder: (context , state)=> ChangePassScreen()),
      
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

        builder: (context,state) {
          final args = GoRouterState
              .of(context)
              .extra;

          //   final  extraData = state.extra as Map<String,dynamic>;
          // if (extraData != null && extraData.isNotEmpty) {
             // return DoctorDetails(
            //     docImage: extraData['docImage']?.toString() ?? '' ,
            //     docName: extraData['docName']?.toString() ?? '' ,
            //     docExperience: extraData['docExperience']?.toString() ?? '',
            //     doctorIndex: extraData['doctorIndex']is int? extraData['doctorIndex']:0,
            //     docDescription: extraData['docDescription']?.toString() ?? '',
            //     docSpeciality: extraData['docSpeciality']?.toString() ?? '',
            //     docEmail: extraData['docEmail']?.toString() ?? '',
            //     docPhoneNumber: extraData['docPhoneNumber']?.toString() ?? '',
            //     startTime: extraData['startTime']?.toString() ?? '',
            //     endTime: extraData['endTime']?.toString() ?? '',
            //     doctorAddress: extraData['doctorAddress']?.toString() ?? '');
          // } else {
            // 🌟 هنا البديل: لو مفيش data مبعوثة، هنجيب بيانات الدكتور من الـ Mock Data مباشرة!
            // (بنفترض إن AllDoctorMockData.doctors دي هي اللستة بتاعتك، وبناخد أول دكتور كافتراضي [0])
            final int? doctorIndex = state.extra as int?;
            final selectedDoctor = (doctorIndex != null && doctorIndex < AllDoctorsMockData.doctorsList.length)
                ? AllDoctorsMockData.doctorsList[doctorIndex]
                : AllDoctorsMockData.doctorsList[0]; // كقيمة افتراضية لو حدث خطأ

            // أخيراً بنرجع الـ Widget ونمرر لها البيانات سواء كانت حقيقية أو من الـ Mock
            return DoctorDetails(
              docName: selectedDoctor.name ?? '',
              docEmail: selectedDoctor.email ?? '',
              docPhoneNumber: selectedDoctor.phone ?? '',
              docSpeciality: selectedDoctor.specialization?.name ?? '',
              docImage: selectedDoctor.photo ?? '',
              docExperience: selectedDoctor.degree ?? '',
              startTime: selectedDoctor.startTime ?? '',
              endTime: selectedDoctor.endTime ?? '',
              doctorAddress: selectedDoctor.address ?? '',
              docDescription: selectedDoctor.description ?? '',
              docLanguage: 'English',
              doctorIndex: selectedDoctor.id ?? 0,
            );
          }
        // }
        )
    ],
  );
}
