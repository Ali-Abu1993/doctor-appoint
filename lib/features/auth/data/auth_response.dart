class AuthResponse {
  final String message;
  final UserData data; // جوه الـ JSON الـ Token والاسم موجودين جوه كائن اسمه data
  final bool status;
  final int code;

  AuthResponse({
    required this.message,
    required this.data,
    required this.status,
    required this.code,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message'] ?? "",
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
      // بنشيك لو الـ data موجودة قبل ما نحولها
      data: UserData.fromJson(json['data']??{}),
    );
  }
}

class UserData {
  final String token;
  final String username;

  UserData({
    required this.token,
    required this.username,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      token: json['token'] ?? "",
      username: json['username'] ?? "",
    );
  }
}
