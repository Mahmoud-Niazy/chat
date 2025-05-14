abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class GetUserDataLoadingState extends ProfileStates{}
class GetUserDataSuccessfullyState extends ProfileStates{}
class GetUserDataErrorState extends ProfileStates{
  final String error ;
  GetUserDataErrorState(this.error);
}