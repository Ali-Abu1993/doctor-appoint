import 'package:dio/dio.dart';
import 'package:doctor_appointment/core/helper/dio_helper.dart';
import 'package:doctor_appointment/features/user_edit_profile/data/user_profile_model.dart';
import 'package:doctor_appointment/features/user_edit_profile/logic/user_profile_states.dart';
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
   final response =   await dioHelper.updateUserProfile(token: userToken??'', data: data.toJason());
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

}