import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get title;

  /// No description provided for @header1.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get header1;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @edit_profile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Name, phone number & email'**
  String get edit_profile_subtitle;

  /// No description provided for @security_and_password.
  ///
  /// In en, this message translates to:
  /// **'Security & Password'**
  String get security_and_password;

  /// No description provided for @security_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Change password & security options'**
  String get security_subtitle;

  /// No description provided for @biometric_login.
  ///
  /// In en, this message translates to:
  /// **'Biometric Login'**
  String get biometric_login;

  /// No description provided for @biometric_success.
  ///
  /// In en, this message translates to:
  /// **'Biometric Login Enabled Successfully!'**
  String get biometric_success;

  /// No description provided for @biometric_failed.
  ///
  /// In en, this message translates to:
  /// **'Authentication Failed or Cancelled'**
  String get biometric_failed;

  /// No description provided for @header2.
  ///
  /// In en, this message translates to:
  /// **'App Preferences'**
  String get header2;

  /// No description provided for @push_notifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get push_notifications;

  /// No description provided for @app_language.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get app_language;

  /// No description provided for @current_language_text.
  ///
  /// In en, this message translates to:
  /// **'Current Language: {langCode}'**
  String current_language_text(String langCode);

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @header3.
  ///
  /// In en, this message translates to:
  /// **'Support & About'**
  String get header3;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @contact_support.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contact_support;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy.'**
  String get privacy_policy;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select App Language'**
  String get select_language;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @logout_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout_dialog_title;

  /// No description provided for @logout_dialog_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logout_dialog_content;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logging_out.
  ///
  /// In en, this message translates to:
  /// **'Logging out'**
  String get logging_out;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcome_back;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to securely access your\n medical records and upcoming\n appointments.'**
  String get login_subtitle;

  /// No description provided for @email_address.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email_address;

  /// No description provided for @email_hint.
  ///
  /// In en, this message translates to:
  /// **'patient@example.com'**
  String get email_hint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @password_hint.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get password_hint;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgot_password;

  /// No description provided for @remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember me for 30 days'**
  String get remember_me;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get sign_in;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @or_continue_with.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get or_continue_with;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @apple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get apple;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dont_have_account;

  /// No description provided for @create_one_here.
  ///
  /// In en, this message translates to:
  /// **'Create one here '**
  String get create_one_here;

  /// No description provided for @create_an_account.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get create_an_account;

  /// No description provided for @register_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill in your details to get started\n with DocPoint.'**
  String get register_subtitle;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get full_name;

  /// No description provided for @name_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Jane Doe'**
  String get name_hint;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @phone_hint.
  ///
  /// In en, this message translates to:
  /// **'(555) 000-0000'**
  String get phone_hint;

  /// No description provided for @create_strong_password.
  ///
  /// In en, this message translates to:
  /// **'Create a strong password'**
  String get create_strong_password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @confirm_password_hint.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm_password_hint;

  /// No description provided for @i_agree_to.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get i_agree_to;

  /// No description provided for @terms_of_service.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service '**
  String get terms_of_service;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and '**
  String get and;

  /// No description provided for @create_account_btn.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account_btn;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get already_have_account;

  /// No description provided for @log_in.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get log_in;

  /// No description provided for @login_success.
  ///
  /// In en, this message translates to:
  /// **'You signed in successfully'**
  String get login_success;

  /// No description provided for @signup_success.
  ///
  /// In en, this message translates to:
  /// **'You signed up successfully'**
  String get signup_success;

  /// No description provided for @err_enter_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get err_enter_email;

  /// No description provided for @err_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get err_valid_email;

  /// No description provided for @err_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get err_enter_password;

  /// No description provided for @err_password_spec.
  ///
  /// In en, this message translates to:
  /// **'Password must contain uppercase, lowercase, numbers, and special characters'**
  String get err_password_spec;

  /// No description provided for @err_enter_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get err_enter_name;

  /// No description provided for @err_enter_phone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get err_enter_phone;

  /// No description provided for @err_phone_digits.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be 11 digits'**
  String get err_phone_digits;

  /// No description provided for @err_valid_phone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get err_valid_phone;

  /// No description provided for @err_enter_password_again.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password again'**
  String get err_enter_password_again;

  /// No description provided for @err_password_match.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password correctly'**
  String get err_password_match;

  /// No description provided for @err_accept_terms.
  ///
  /// In en, this message translates to:
  /// **'Please accept terms and conditions'**
  String get err_accept_terms;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
