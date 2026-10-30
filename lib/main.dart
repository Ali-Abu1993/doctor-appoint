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

import 'core/utils/app_extensions.dart';
import 'core/utils/colors_manager.dart';
import 'l10n/app_localizations.dart';

Future firebaseMessagingHandler(RemoteMessage message) async {
  print("تم استلام إشعار في الخلفية: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        BlocProvider(create: (context) => LocalizationCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
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
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,

                    supportedLocales: AppLocalizations.supportedLocales,
                    themeMode: currentThemeMode,

                    theme: ThemeData(
                      appBarTheme: AppBarTheme(
                        backgroundColor: ColorsManager.primary,
                        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                            color:context.isDark? Colors.white70:Colors.white),
                        iconTheme: IconThemeData(
                          color: Colors.white70,size: 20,
                        ),
                      ),
                      brightness: Brightness.light,
                      scaffoldBackgroundColor: Color.fromRGBO(231, 238, 255, 1),
                      colorScheme: .fromSeed(
                        seedColor: Colors.deepPurple,
                        background: ColorsManager.primary,
                        brightness: Brightness.light,
                        primary: ColorsManager.primary,
                        secondary: Colors.white,
                        onSurface: ColorsManager.primary
                      ),
                    ),
                    darkTheme: ThemeData(
                      brightness: Brightness.dark,
                      buttonTheme: ButtonThemeData(
                        buttonColor: Colors.blue,
                        disabledColor: Colors.blue[200],
                        textTheme: ButtonTextTheme.accent,
                      ),
                      primaryColor: Colors.blue[200],

                      appBarTheme: AppBarTheme(
                        backgroundColor: Colors.black38,
                        elevation: 0,
                      ),

                      scaffoldBackgroundColor: Colors.black12,
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: Colors.grey.shade100,
                        background: Colors.black12,
                        primary: Colors.white,
                        secondary: Colors.grey.shade400,
                        brightness: Brightness.dark,
                        onSurface: Colors.white70
                      ),
                    ),

                    routerConfig: AppRouter.router,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
