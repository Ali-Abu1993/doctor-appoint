class RegisterBody {
  final String name;
  final String email;
  final String phone;
  final String gender; // لو السيرفر بياخد 0 و 1 كـ String
  final String password;
  final String passwordConfirmation;

  RegisterBody({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.password,
    required this.passwordConfirmation,
  });

  // الـ Function اللي بتحول البيانات لـ Map عشان تتبعت للسيرفر
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
