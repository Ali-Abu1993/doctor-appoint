class UserProfileModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String gender;

  const UserProfileModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
  });

  factory UserProfileModel.fromJson(Map<String,dynamic>json){
    return UserProfileModel(fullName: json['fullName'] ?? '',
        email: json['emailAddress'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        gender: json["gender"] ==0 || json['gender']==0? 'Male':'Female');
  }
  Map<String,dynamic>toJason(){
    return {
      'fullName': fullName,
      'email':email,
      'phoneNumber':phoneNumber,
      'gender':gender=='Male'? 0:1

    };
  }
}
