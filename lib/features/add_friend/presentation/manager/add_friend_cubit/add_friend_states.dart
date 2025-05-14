abstract class AddFriendStates{}

class AddFriendInitialState extends AddFriendStates{}

class SendFriendRequestLoadingState extends AddFriendStates{}
class SendFriendRequestSuccessfullyState extends AddFriendStates{}
class SendFriendRequestErrorState extends AddFriendStates{
  final String error;
  SendFriendRequestErrorState(this.error);
}