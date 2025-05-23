abstract class EditProfileStates {}

class EditProfileInitialState extends EditProfileStates{}

class EditProfileErrorState extends EditProfileStates{
  final String error;
  EditProfileErrorState(this.error);
}


class GetUserDataLoadingState extends EditProfileStates{}
class GetUserDataSuccessfullyState extends EditProfileStates{}


class UpdateUserDataLoadingState extends EditProfileStates{}
class UpdateUserDataSuccessfullyState extends EditProfileStates{}

class NoImageSelectedState extends EditProfileStates{}
class ImageSelectedSuccessfullyState extends EditProfileStates{}



