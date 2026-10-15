import 'dart:io';

import 'package:doctor_appointment/features/user_edit_profile/logic/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String? photoUrl;

  const UserProfileModel({
    this.photoUrl,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
  });

  factory UserProfileModel.fromJson(Map<String,dynamic>json){
    return UserProfileModel(fullName: json['fullName'] ?? '',
        email: json['emailAddress'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        photoUrl: json['photoUrl'] ?? '',
        gender: json["gender"] ==0 || json['gender']==0? 'Male':'Female');
  }
  Map<String,dynamic>toJson(){
    return {
      'fullName': fullName,
      'email':email,
      'phoneNumber':phoneNumber,
      'photoUrl':photoUrl,
      'gender':gender=='Male'? 0:1

    };
  }

}
Future pickAndUploadImage(BuildContext context) async{
  ImagePicker imagePicker = ImagePicker();
  final  image =await imagePicker.pickImage(source: ImageSource.gallery);
  if(image!=null) {
    final File imageFile = File(image.path);
    context.read<ProfileCubit>().updateProfilePhoto(imageFile);
  }
}
