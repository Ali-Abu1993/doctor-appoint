import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:doctor_appointment/core/helper/dio_helper.dart';
import 'package:doctor_appointment/features/user_edit_profile/data/user_profile_model.dart';
import 'package:doctor_appointment/features/user_edit_profile/logic/user_profile_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constance/api_const.dart';

class ProfileCubit extends Cubit<UserProfileStates> {
  final DioHelper dioHelper;
  ProfileCubit(this.dioHelper):super(ProfileInitialState());

  void fetchUserProfile({required String userToken}) async {
    emit(ProfileLoadingState());
    try{
      final response = await dioHelper.dio.get(ApiConst.getProfileURL,options: Options(
        headers: {
          'Authorization': 'Bearer $userToken'
        }
        )
      );
      if(response.statusCode==200){
        final userModel = UserProfileModel.fromJson(response.data);
        emit(ProfileSuccessState(userModel));
      }else{
        emit(ProfileErrorState(response.data['message']?? 'Error Fetching data'));
      }
    }catch(ex){
      emit(ProfileErrorState(ex.toString()));
    }

}
Future updateUserData({String? userToken,required UserProfileModel data})async{
    emit(UpdateProfileLoadingState());
    try{
   final response =   await dioHelper.updateUserProfile(token: userToken??'',
       data: data.toJson());
   if(response.statusCode==200){
     final newUserModel= UserProfileModel.fromJson(response.data['data']);
     emit(UpdateProfileSuccessState(newUserModel));
     emit(ProfileSuccessState(newUserModel));
   }else{
     emit(UpdateProfileErrorState(response.data['data'] ?? 'Error Fetching data'));
   }

    }catch(error){
         emit(UpdateProfileErrorState(error.toString()));


    }
}
Future<String?> getGender(String gender) async{
  final user = FirebaseAuth.instance.currentUser;
    emit(UpdateGenderLoading());
    try{
    await  FirebaseFirestore.instance.collection('Users').doc(user?.uid).
      update({'gender': gender});

    emit(UpdateGenderSuccess());


    }catch (e){
      emit(UpdateGenderFailure(e.toString()));
    }
    return null;
}
Future updateProfilePhoto(File image) async{
final user =FirebaseAuth.instance.currentUser;
if(user==null) return;
emit(EditPhotoLoadingState());
try{
  final storageRef =
  FirebaseStorage.instance.ref().child('users_photos').child('${user.uid}.jpg');
UploadTask uploadTask =storageRef.putFile(image);
 TaskSnapshot snapshot =await uploadTask;
 String downloadUrl = await snapshot.ref.getDownloadURL();
 await user.updatePhotoURL(downloadUrl);
 emit(EditPhotoSuccessState(downloadUrl));

}catch(e){
  emit(EditPhotoErrorState(e.toString()));
}
}

}