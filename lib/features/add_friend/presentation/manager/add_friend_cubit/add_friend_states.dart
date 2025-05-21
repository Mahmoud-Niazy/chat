abstract class AddFriendStates{}

class AddFriendInitialState extends AddFriendStates{}

class AddFriendErrorState extends AddFriendStates{
  final String error;
  AddFriendErrorState(this.error);
}


class SendFriendRequestLoadingState extends AddFriendStates{}
class SendFriendRequestSuccessfullyState extends AddFriendStates{}

class FindUserLoadingState extends AddFriendStates{}
class FindUserSuccessfullyState extends AddFriendStates{}