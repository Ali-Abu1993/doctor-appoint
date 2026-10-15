
import 'package:doctor_appointment/features/user_edit_profile/data/user_profile_model.dart';

class UserProfileStates {}
class ProfileInitialState extends UserProfileStates{}
class ProfileLoadingState extends UserProfileStates{}
class ProfileSuccessState extends UserProfileStates{
  final UserProfileModel user;
  ProfileSuccessState(this.user);
}
class ProfileErrorState extends UserProfileStates{
  final String message;
  ProfileErrorState(this.message);
}
class UpdateProfileLoadingState extends UserProfileStates{}
class UpdateProfileSuccessState extends UserProfileStates{
  final UserProfileModel? user;
  UpdateProfileSuccessState(this.user);
}
class UpdateProfileErrorState extends UserProfileStates{
  final String message;
  UpdateProfileErrorState(this.message);
}
class EditPhotoLoadingState extends UserProfileStates{}
class EditPhotoSuccessState extends UserProfileStates{
  final String photoUrl;
  EditPhotoSuccessState(this.photoUrl);
}
class EditPhotoErrorState extends UserProfileStates{
  final String message;
  EditPhotoErrorState(this.message);
}
class UpdateGenderLoading extends UserProfileStates{}
class UpdateGenderSuccess extends UserProfileStates{}
class UpdateGenderFailure extends UserProfileStates{
  final String message;
  UpdateGenderFailure(this.message);
}