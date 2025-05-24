abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileErrorState extends ProfileStates{
  final String error ;
  ProfileErrorState(this.error);
}

class GetUserDataLoadingState extends ProfileStates{}
class GetUserDataSuccessfullyState extends ProfileStates{}
