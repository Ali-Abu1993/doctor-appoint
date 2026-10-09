class LoginRequestBody {
  final String email;
  final String password;

  LoginRequestBody({
    required this.email,
    required this.password,
  });

  // تحويل البيانات لـ JSON عشان تتبعت في الـ Body
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
