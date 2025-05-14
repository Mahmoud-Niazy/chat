abstract class AddFriendStates{}

class AddFriendInitialState extends AddFriendStates{}

class SendFriendRequestLoadingState extends AddFriendStates{}
class SendFriendRequestSuccessfullyState extends AddFriendStates{}
class SendFriendRequestErrorState extends AddFriendStates{
  final String error;
  SendFriendRequestErrorState(this.error);
}

class FindUserLoadingState extends AddFriendStates{}
class FindUserSuccessfullyState extends AddFriendStates{}
class FindUserErrorState extends AddFriendStates{
  final String error;
  FindUserErrorState(this.error);
}