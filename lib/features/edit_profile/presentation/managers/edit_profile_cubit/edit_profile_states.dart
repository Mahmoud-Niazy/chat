abstract class EditProfileStates {}

class EditProfileInitialState extends EditProfileStates{}

class GetUserDataLoadingState extends EditProfileStates{}
class GetUserDataSuccessfullyState extends EditProfileStates{}
class GetUserDataErrorState extends EditProfileStates{
  final String error;
  GetUserDataErrorState(this.error);
}

class UpdateUserDataLoadingState extends EditProfileStates{}
class UpdateUserDataSuccessfullyState extends EditProfileStates{}
class UpdateUserDataErrorState extends EditProfileStates{
  final String error;
  UpdateUserDataErrorState(this.error);
}

class NoImageSelectedState extends EditProfileStates{}
class ImageSelectedSuccessfullyState extends EditProfileStates{}



