import 'package:doctor_appointment/core/helper/theme_cubit.dart';
import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/features/auth/logic/cubit.dart';
import 'package:doctor_appointment/l10n/app_localizations.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/service/biometrics_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/logic/state.dart';
import '../helper/localization_cubit.dart';
import '../routing/routes.dart';
import 'custom_widgets/build_info_tile.dart';
import 'custom_widgets/build_section_title.dart';
import 'custom_widgets/build_settings_group.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // حالات التحكم بالخصائص local state
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;
  bool biometricsEnabled = true;
  String selectedLanguage = 'English';
  User? user = FirebaseAuth.instance.currentUser;
  final biometricService = BiometricsService();

  // اللون الأزرق الطبي الأساسي للتطبيق


  @override
  Widget build(BuildContext context) {
    late  AppLocalizations? local = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. كارت الملف الشخصي المصغر
                buildInfoTile(
                    Icons.person, user?.displayName ?? '', user?.email ?? '',
                    TxtStyle.font15W600DarkBlue, TxtStyle.font11BoldGrey
                ),

                const SizedBox(height: 24),

                // 2. قسم إعدادات الحساب
                buildSectionTitle(AppLocalizations.of(context)!.header1),
                buildSettingsGroup([
                  buildListTile(
                    icon: Icons.person_outline_rounded,
                    title: local!.edit_profile,
                    subtitle: local.edit_profile_subtitle,
                    onTap: () {
                      context.pushNamed(AppRouter.editProfileScreen);
                    },
                  ),
                  const Divider(height: 1, indent: 56),
                  buildListTile(
                    icon: Icons.lock_outline_rounded,
                    title: local.security_and_password,
                    subtitle: local.security_subtitle,
                    onTap: () {
                      context.goNamed(AppRouter.kChangePassScreen);
                    },
                  ),
                  const Divider(height: 1, indent: 56),
                  buildSwitchTile(
                    icon: Icons.fingerprint_rounded,
                    title: local.biometric_login,
                    value: biometricsEnabled,
                    onChanged: (val) async {
                      if (val) {
                        bool authenticated = await biometricService
                            .authenticateWithBiometric();
                        if (authenticated) {
                          setState(() {
                            biometricsEnabled = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  local.biometric_success)));
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(
                                  local.biometric_failed)));
                        }
                      }
                      else {
                        setState(() {
                          biometricsEnabled = false;
                        });
                      }
                    },
                  ),
                ]),

                const SizedBox(height: 24),

                // 3. قسم التفضيلات والتطبيق
                buildSectionTitle(local.header2),
                buildSettingsGroup([
                  buildSwitchTile(
                    icon: Icons.notifications_none_rounded,
                    title: local.push_notifications,
                    value: notificationsEnabled,
                    onChanged: (val) =>
                        setState(() => notificationsEnabled = val),
                  ),
                  const Divider(height: 1, indent: 56),
                  buildListTile(
                      icon: Icons.language_rounded,
                      title: local.app_language,
                      trailingText: selectedLanguage,
                      onTap: () {

                        showLanguageBottomSheet(context);

                      }),
                  Text(
                    "Current Language: ${Localizations.localeOf(context).languageCode}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ]

                ),
                const Divider(height: 1, indent: 56),
                buildSwitchTile(
                  icon: Icons.dark_mode_outlined,
                  title: local.dark_mode,
                  value: context.watch<ThemeCubit>().state==ThemeMode.dark,
                  onChanged: (val) {
                    setState(() {
                      context.read<ThemeCubit>().changeTheme(val);
                    });
                  },
                ),


          const SizedBox(height: 24),

          // 4. قسم الدعم والمساعدة
          buildSectionTitle(local.header3),
          buildSettingsGroup([
            buildListTile(
              icon: Icons.help_outline_rounded,
              title: local.faq,
              onTap: () {},
            ),
            const Divider(height: 1, indent: 56),
            buildListTile(
              icon: Icons.headset_mic_outlined,
              title: local.contact_support,
              onTap: () {},
            ),
            const Divider(height: 1, indent: 56),
            buildListTile(
              icon: Icons.privacy_tip_outlined,
              title: local.privacy_policy,
              onTap: () {},
            ),
          ]),

          const SizedBox(height: 28),

          // 5. زر تسجيل الخروج
          BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is AuthSuccessState) {
                showLogoutDialog(context);

                context.go(AppRouter.kLoginScreen);
              }
              if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.em)));
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 52,
                child:
                OutlinedButton.icon(
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                  },
                  icon: const Icon(
                      Icons.logout_rounded, color: Colors.redAccent),
                  label: state is AuthLoadingState ? Center(
                      child: CircularProgressIndicator()) :
                  Text(
                    local.logout,
                    style: TxtStyle.font16BoldRed,
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red.shade200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    backgroundColor: Colors.red.shade50.withOpacity(0.4),
                  ),
                ),


              );
            },
          ),

          const SizedBox(height: 20),
        ],
        ),
      ),
    ));
  }

  // WIDGETS BUILDERS


  // MODALS & DIALOGS

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'اختر لغة التطبيق',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('العربية'),
                trailing: selectedLanguage == 'العربية'
                    ? const Icon(Icons.check, color: primaryBlue)
                    : null,
                onTap: () {
                  setState(() => selectedLanguage = 'العربية');

                  context.read<LocalizationCubit>().changeLanguage(const Locale('ar'));
                  bool isRtl = Directionality.of(context) == TextDirection.rtl;
                  debugPrint("Is Right-to-Left: $isRtl");
                  context.pop(); // غلق الـ BottomSheet باستخدام GoRouter
                },
              ),
              ListTile(
                title: const Text('English'),
                trailing: selectedLanguage == 'English'
                    ? const Icon(Icons.check, color: primaryBlue)
                    : null,
                onTap: () {
                  setState(() => selectedLanguage = 'English');
                  bool isRtl = Directionality.of(context) == TextDirection.rtl;
                  debugPrint("Is Right-to-Left: $isRtl");
                  context.read<LocalizationCubit>().changeLanguage(const Locale('en'));
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            title: const Text('Log out'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text(
                    'Cancel', style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  context.pop();
                  // context.go('/login'); // التوجه لصفحة تسجيل الدخول بـ GoRouter
                },
                child: const Text(
                    'Logging out', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }
}