import 'package:doctor_appointment/core/helper/localization_cubit.dart';
import 'package:doctor_appointment/core/helper/theme_cubit.dart';
import 'package:doctor_appointment/core/routing/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:doctor_appointment/firebase_options.dart';

import 'l10n/app_localizations.dart';


Future firebaseMessagingHandler(RemoteMessage message) async {
  print("تم استلام إشعار في الخلفية: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocalizationCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<LocalizationCubit, Locale>(
        builder: (context, currentLocale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, currentThemeMode) {
              return ScreenUtilInit(
                  designSize: const Size(360, 690),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (_, child) {
                    return MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      title: 'Doctor App',
                      locale: currentLocale,
                      localizationsDelegates: AppLocalizations
                          .localizationsDelegates,

                      supportedLocales: AppLocalizations.supportedLocales,
                      themeMode: currentThemeMode,

                      theme: ThemeData(
                        brightness: Brightness.light,
                        scaffoldBackgroundColor: Color.fromRGBO(
                            231, 238, 255, 1),

                        colorScheme: .fromSeed(seedColor: Colors.deepPurple,brightness: Brightness.light),
                      ),
                      darkTheme: ThemeData(
                        brightness: Brightness.dark,
                        scaffoldBackgroundColor: const Color(0xFF121212),
                        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
                      ),

                      routerConfig: AppRouter.router,

                    );
                  }
              );
            },
          );
        },
      ),
    );
  }
}
