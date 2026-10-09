import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_appointment/features/user_edit_profile/data/user_profile_model.dart';
import 'package:doctor_appointment/features/user_edit_profile/logic/user_profile_states.dart';
import 'package:doctor_appointment/core/mock_data/data/user_profile_mock_data.dart';

class MockProfileCubit extends Cubit<UserProfileStates> {
  MockProfileCubit() : super(ProfileInitialState());

  Future<void> fetchUserProfile({String? userToken}) async {
    emit(ProfileLoadingState());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(ProfileSuccessState(UserProfileMockData.currentUser));
  }

  Future<void> updateUserData({String? userToken, required UserProfileModel data}) async {
    emit(UpdateProfileLoadingState());
    await Future.delayed(const Duration(milliseconds: 300));
    final updated = UserProfileMockData.updateProfile(data);
    emit(UpdateProfileSuccessState(updated));
    emit(ProfileSuccessState(updated));
  }
}
