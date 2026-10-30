// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Settings';

  @override
  String get header1 => 'Account Settings';

  @override
  String get edit_profile => 'Edit Profile';

  @override
  String get edit_profile_subtitle => 'Name, phone number & email';

  @override
  String get security_and_password => 'Security & Password';

  @override
  String get security_subtitle => 'Change password & security options';

  @override
  String get biometric_login => 'Biometric Login';

  @override
  String get biometric_success => 'Biometric Login Enabled Successfully!';

  @override
  String get biometric_failed => 'Authentication Failed or Cancelled';

  @override
  String get header2 => 'App Preferences';

  @override
  String get push_notifications => 'Push Notifications';

  @override
  String get app_language => 'App Language';

  @override
  String current_language_text(String langCode) {
    return 'Current Language: $langCode';
  }

  @override
  String get dark_mode => 'Dark Mode';

  @override
  String get header3 => 'Support & About';

  @override
  String get faq => 'FAQ';

  @override
  String get contact_support => 'Contact Support';

  @override
  String get privacy_policy => 'Privacy Policy.';

  @override
  String get logout => 'Logout';

  @override
  String get select_language => 'Select App Language';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'English';

  @override
  String get logout_dialog_title => 'Log out';

  @override
  String get logout_dialog_content => 'Are you sure you want to log out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get logging_out => 'Logging out';

  @override
  String get welcome_back => 'Welcome Back';

  @override
  String get login_subtitle =>
      'Sign in to securely access your\n medical records and upcoming\n appointments.';

  @override
  String get email_address => 'Email Address';

  @override
  String get email_hint => 'patient@example.com';

  @override
  String get password => 'Password';

  @override
  String get password_hint => '••••••••';

  @override
  String get forgot_password => 'Forgot password?';

  @override
  String get remember_me => 'Remember me for 30 days';

  @override
  String get sign_in => 'Sign in';

  @override
  String get loading => 'Loading...';

  @override
  String get or_continue_with => 'Or continue with';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get dont_have_account => 'Don\'t have an account? ';

  @override
  String get create_one_here => 'Create one here ';

  @override
  String get create_an_account => 'Create an account';

  @override
  String get register_subtitle =>
      'Fill in your details to get started\n with DocPoint.';

  @override
  String get full_name => 'Full name';

  @override
  String get name_hint => 'e.g. Jane Doe';

  @override
  String get gender => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get phone_number => 'Phone Number';

  @override
  String get phone_hint => '(555) 000-0000';

  @override
  String get create_strong_password => 'Create a strong password';

  @override
  String get confirm_password => 'Confirm Password';

  @override
  String get confirm_password_hint => 'Confirm password';

  @override
  String get i_agree_to => 'I agree to the ';

  @override
  String get terms_of_service => 'Terms of Service ';

  @override
  String get and => 'and ';

  @override
  String get create_account_btn => 'Create Account';

  @override
  String get already_have_account => 'Already have an account? ';

  @override
  String get log_in => 'Log in';

  @override
  String get login_success => 'You signed in successfully';

  @override
  String get signup_success => 'You signed up successfully';

  @override
  String get err_enter_email => 'Please enter your email address';

  @override
  String get err_valid_email => 'Please enter a valid email address';

  @override
  String get err_enter_password => 'Please enter your password';

  @override
  String get err_password_spec =>
      'Password must contain uppercase, lowercase, numbers, and special characters';

  @override
  String get err_enter_name => 'Please enter your name';

  @override
  String get err_enter_phone => 'Please enter your phone number';

  @override
  String get err_phone_digits => 'Phone number must be 11 digits';

  @override
  String get err_valid_phone => 'Please enter a valid phone number';

  @override
  String get err_enter_password_again => 'Please enter your password again';

  @override
  String get err_password_match => 'Please enter your password correctly';

  @override
  String get err_accept_terms => 'Please accept terms and conditions';

  @override
  String get profile_title => 'Profile';

  @override
  String get edit_profile_title => 'Edit profile';

  @override
  String member_since(String year) {
    return 'Member since $year';
  }

  @override
  String get change_profile_photo => 'change profile photo';

  @override
  String get update_profile => 'Update profile';

  @override
  String get updating => 'Updating...';

  @override
  String get edit_your_profile => 'Edit your profile';

  @override
  String get profile_updated_success => 'Profile updated successfully';

  @override
  String get image_updated_success => 'Image updated successfully';

  @override
  String get default_user_name => 'User';

  @override
  String get default_email => 'noemail@nodomain.com';

  @override
  String get default_phone => '+01 000 0000 0000';

  @override
  String get not_specified => 'Not Specified';

  @override
  String get home_icon => 'Home';

  @override
  String get search_icon => 'Search';

  @override
  String get booking_icon => 'Booking';

  @override
  String get available_today => 'Available Today';

  @override
  String get not_available_today => 'Not Available Today';

  @override
  String reviews_format(String count) {
    return '($count reviews)';
  }

  @override
  String get view_profile => 'View Profile';

  @override
  String get book_now => 'Book Now';

  @override
  String get good_morning => 'Good Morning!';

  @override
  String get good_afternoon => 'Good Afternoon!';

  @override
  String get good_evening => 'Good Evening!';

  @override
  String hello_user(String name) {
    return 'Hello, $name!';
  }

  @override
  String get search_hint => 'Search doctors, specialties, clinics...';

  @override
  String get specialities => 'Specialities';

  @override
  String get see_all => 'see all';

  @override
  String get recommended_doctors => 'Recommended Doctors';

  @override
  String get view_all => 'view all';

  @override
  String get settings => 'Settings';

  @override
  String get profile => 'Profile';

  @override
  String get booking_confirmed_notification =>
      'Your appointment with the doctor has been confirmed';

  @override
  String get new_promotions_notification => 'New promotions for medical plans';

  @override
  String get doc_app_title => 'Home';

  @override
  String get doctor_details_title => 'Doctor Details';

  @override
  String get about => 'About';

  @override
  String languages_format(String languages) {
    return 'Languages: $languages';
  }

  @override
  String address_format(String address) {
    return 'Address is \'$address\'';
  }

  @override
  String available_between_format(String time) {
    return 'Available between: $time';
  }

  @override
  String get select_date => 'Select Date';

  @override
  String get choose_date => 'choose date';

  @override
  String get available_time => 'Available Time';

  @override
  String get morning => 'Morning';

  @override
  String get evening => 'Evening';

  @override
  String get booking_completed => 'Booking is completed';

  @override
  String get confirm_appointment => 'Confirm appointment';

  @override
  String get please_select_time_slot => 'Please select a time slot';

  @override
  String get find_a_doctor => 'Find a Doctor';

  @override
  String filters_count(String count) {
    return 'Filters ($count)';
  }

  @override
  String get rating_filter => 'Rating 4.5+';

  @override
  String get distance_filter => 'Distance: < 5mi';

  @override
  String get speciality_title_1 => 'Cardiology';

  @override
  String get speciality_title_2 => 'Dental';

  @override
  String get speciality_title_3 => 'General';

  @override
  String get speciality_title_4 => 'Endocrinology';
}
