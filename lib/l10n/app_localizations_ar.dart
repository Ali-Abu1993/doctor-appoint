// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get title => 'الإعدادات';

  @override
  String get header1 => 'إعدادات الحساب';

  @override
  String get edit_profile => 'تعديل الملف الشخصي';

  @override
  String get edit_profile_subtitle => 'الاسم، رقم الهاتف والبريد الإلكتروني';

  @override
  String get security_and_password => 'الأمان وكلمة المرور';

  @override
  String get security_subtitle => 'تغيير كلمة المرور وخيارات الأمان';

  @override
  String get biometric_login => 'تسجيل الدخول بالبصمة';

  @override
  String get biometric_success => 'تم تفعيل تسجيل الدخول بالبصمة بنجاح!';

  @override
  String get biometric_failed => 'فشلت عملية المصادقة أو تم إلغاؤها';

  @override
  String get header2 => 'تفضيلات التطبيق';

  @override
  String get push_notifications => 'الإشعارات اللحظية';

  @override
  String get app_language => 'لغة التطبيق';

  @override
  String current_language_text(String langCode) {
    return 'اللغة الحالية: $langCode';
  }

  @override
  String get dark_mode => 'الوضع الداكن';

  @override
  String get header3 => 'الدعم والمساعدة';

  @override
  String get faq => 'الأسئلة الشائعة';

  @override
  String get contact_support => 'التواصل مع الدعم';

  @override
  String get privacy_policy => 'سياسة الخصوصية.';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get select_language => 'اختر لغة التطبيق';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'English';

  @override
  String get logout_dialog_title => 'تسجيل الخروج';

  @override
  String get logout_dialog_content => 'هل أنت ألكيد من رغبتك في تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get logging_out => 'جاري تسجيل الخروج';

  @override
  String get welcome_back => 'مرحباً بعودتك';

  @override
  String get login_subtitle =>
      'سجل الدخول بأمان للوصول إلى\n سجلاتك الطبية ومواعيدك القادمة.';

  @override
  String get email_address => 'البريد الإلكتروني';

  @override
  String get email_hint => 'patient@example.com';

  @override
  String get password => 'كلمة المرور';

  @override
  String get password_hint => '••••••••';

  @override
  String get forgot_password => 'هل نسيت كلمة المرور؟';

  @override
  String get remember_me => 'تذكرني لمدة 30 يوماً';

  @override
  String get sign_in => 'تسجيل الدخول';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get or_continue_with => 'أو المتابعة باستخدام';

  @override
  String get google => 'جوجل';

  @override
  String get apple => 'أبل';

  @override
  String get dont_have_account => 'ليس لديك حساب؟ ';

  @override
  String get create_one_here => 'أنشئ حساباً من هنا ';

  @override
  String get create_an_account => 'إنشاء حساب';

  @override
  String get register_subtitle => 'املأ بياناتك للبدء مع\n DocPoint.';

  @override
  String get full_name => 'الاسم الكامل';

  @override
  String get name_hint => 'مثال: أحمد محمد';

  @override
  String get gender => 'الجنس';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get phone_number => 'رقم الهاتف';

  @override
  String get phone_hint => '+2010 000 000 000';

  @override
  String get create_strong_password => 'أنشئ كلمة مرور قوية';

  @override
  String get confirm_password => 'تأكيد كلمة المرور';

  @override
  String get confirm_password_hint => 'تأكيد كلمة المرور';

  @override
  String get i_agree_to => 'أوافق على ';

  @override
  String get terms_of_service => 'شروط الخدمة ';

  @override
  String get and => 'و ';

  @override
  String get create_account_btn => 'إنشاء الحساب';

  @override
  String get already_have_account => 'لديك حساب بالفعل؟ ';

  @override
  String get log_in => 'تسجيل الدخول';

  @override
  String get login_success => 'تم تسجيل الدخول بنجاح';

  @override
  String get signup_success => 'تم إنشاء الحساب بنجاح';

  @override
  String get err_enter_email => 'الرجاء إدخال البريد الإلكتروني';

  @override
  String get err_valid_email => 'الرجاء إدخال بريد إلكتروني صالح';

  @override
  String get err_enter_password => 'الرجاء إدخال كلمة المرور';

  @override
  String get err_password_spec =>
      'يجب أن تحتوي كلمة المرور على حروف كبيرة وصغيرة وأرقام ورموز خاصة';

  @override
  String get err_enter_name => 'الرجاء إدخال اسمك';

  @override
  String get err_enter_phone => 'الرجاء إدخال رقم الهاتف';

  @override
  String get err_phone_digits => 'يجب أن يتكون رقم الهاتف من 11 رقماً';

  @override
  String get err_valid_phone => 'الرجاء إدخال رقم هاتف صالح';

  @override
  String get err_enter_password_again => 'الرجاء إدخال كلمة المرور مرة أخرى';

  @override
  String get err_password_match => 'الرجاء إدخال كلمة المرور بشكل صحيح';

  @override
  String get err_accept_terms => 'الرجاء قبول الشروط والأحكام';

  @override
  String get profile_title => 'الملف الشخصي';

  @override
  String get edit_profile_title => 'تعديل الملف الشخصي';

  @override
  String member_since(String year) {
    return 'عضو منذ $year';
  }

  @override
  String get change_profile_photo => 'تغيير صورة الملف الشخصي';

  @override
  String get update_profile => 'تحديث الملف الشخصي';

  @override
  String get updating => 'جاري التحديث...';

  @override
  String get edit_your_profile => 'تعديل ملفك الشخصي';

  @override
  String get profile_updated_success => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get image_updated_success => 'تم تحديث الصورة بنجاح';

  @override
  String get default_user_name => 'مستخدم';

  @override
  String get default_email => 'noemail@nodomain.com';

  @override
  String get default_phone => '+01 000 0000 0000';

  @override
  String get not_specified => 'غير محدد';

  @override
  String get home_icon => 'الرئيسية';

  @override
  String get search_icon => 'البحث';

  @override
  String get booking_icon => 'حجز';

  @override
  String get available_today => 'متاح اليوم';

  @override
  String get not_available_today => 'غير متاح اليوم';

  @override
  String reviews_format(String count) {
    return '($count تقييم)';
  }

  @override
  String get view_profile => 'عرض الملف الشخصي';

  @override
  String get book_now => 'احجز الان';

  @override
  String get good_morning => 'صباح الخير!';

  @override
  String get good_afternoon => 'مساء الخير!';

  @override
  String get good_evening => 'مساء الخير!';

  @override
  String hello_user(String name) {
    return 'أهلاً، $name!';
  }

  @override
  String get search_hint => 'ابحث عن الأطباء، التخصصات، العيادات...';

  @override
  String get specialities => 'التخصصات';

  @override
  String get see_all => 'عرض الكل';

  @override
  String get recommended_doctors => 'الأطباء الموصى بهم';

  @override
  String get view_all => 'عرض الكل';

  @override
  String get settings => 'الإعدادات';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get booking_confirmed_notification => 'تم تأكيد موعد حجزك مع الدكتور';

  @override
  String get new_promotions_notification => 'عروض جديدة للخطط الطبية';

  @override
  String get doc_app_title => 'Home';

  @override
  String get doctor_details_title => 'تفاصيل الطبيب';

  @override
  String get about => 'نبذة عن الطبيب';

  @override
  String languages_format(String languages) {
    return 'اللغات: $languages';
  }

  @override
  String address_format(String address) {
    return 'العنوان \'$address\'';
  }

  @override
  String available_between_format(String time) {
    return 'متاح بين: $time';
  }

  @override
  String get select_date => 'اختر التاريخ';

  @override
  String get choose_date => 'اختر تاريخاً';

  @override
  String get available_time => 'الأوقات المتاحة';

  @override
  String get morning => 'صباحاً';

  @override
  String get evening => 'مساءً';

  @override
  String get booking_completed => 'تم الحجز بنجاح';

  @override
  String get confirm_appointment => 'تأكيد الموعد';

  @override
  String get please_select_time_slot => 'الرجاء اختيار وقت الحجز';

  @override
  String get find_a_doctor => 'البحث عن طبيب';

  @override
  String filters_count(String count) {
    return 'الفلاتر ($count)';
  }

  @override
  String get rating_filter => 'التقييم 4.5+';

  @override
  String get distance_filter => 'المسافة: أقل من 5 أميال';

  @override
  String get speciality_title_1 => 'أمراض القلب';

  @override
  String get speciality_title_2 => 'الأسنان';

  @override
  String get speciality_title_3 => 'عام';

  @override
  String get speciality_title_4 => 'إخصائي الغدد الصماء';
}
