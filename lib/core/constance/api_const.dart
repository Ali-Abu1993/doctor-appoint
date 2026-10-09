class ApiConst {
  static const String baseUrl ="https://vcare.integration25.com/api";
  static const String registerURL ="$baseUrl/auth/register";
  static const String loginURL ="$baseUrl/auth/login";
  static const String allDoctorsURL ="$baseUrl/doctor/index";
  static const String searchDoctorsURL ="$baseUrl/doctor/doctor-search?name=Finn";
  static const String getProfileURL ="$baseUrl/user/profile";
  static const String updateProfileURL ="$baseUrl/user/update";
  static const String homeURL ="$baseUrl/home/index";
  static const String showDoctorURL ="$baseUrl/doctor/show/3";
  static const String storeAppointmentURL ="$baseUrl/appointment/store";
}