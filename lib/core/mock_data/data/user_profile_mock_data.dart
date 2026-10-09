import 'package:doctor_appointment/features/user_edit_profile/data/user_profile_model.dart';

abstract class UserProfileMockData {
  static UserProfileModel currentUser = const UserProfileModel(
    fullName: "Sarah Connor",
    email: "sarah.connor@example.com",
    phoneNumber: "+20 101 234 5678",
    gender: "Female",
  );

  static UserProfileModel updateProfile(UserProfileModel newProfile) {
    currentUser = newProfile;
    return currentUser;
  }
}
