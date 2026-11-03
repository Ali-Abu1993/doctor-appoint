import 'package:doctor_appointment/features/user_edit_profile/data/user_profile_model.dart';

abstract class UserProfileMockData {
  static UserProfileModel currentUser = const UserProfileModel(
    fullName: "",
    email: "",
    phoneNumber: "",
    gender: "",
  );

  static UserProfileModel updateProfile(UserProfileModel newProfile) {
    currentUser = newProfile;
    return currentUser;
  }
}
