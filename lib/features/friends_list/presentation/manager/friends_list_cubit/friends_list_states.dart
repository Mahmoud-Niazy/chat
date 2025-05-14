abstract class FriendsListStates {}

class FriendsListInitialState extends FriendsListStates{}

class GetFriendsListLoadingState extends FriendsListStates{}
class GetFriendsListSuccessfullyState extends FriendsListStates{}
class GetFriendsListErrorState extends FriendsListStates{
  final String error;
  GetFriendsListErrorState(this.error);
}

class DeleteFriendLoadingState extends FriendsListStates{}
class DeleteFriendSuccessfullyState extends FriendsListStates{}
class DeleteFriendErrorState extends FriendsListStates{
  final String error;
  DeleteFriendErrorState(this.error);
}

class BlockFriendLoadingState extends FriendsListStates{}
class BlockFriendSuccessfullyState extends FriendsListStates{}
class BlockFriendErrorState extends FriendsListStates{
  final String error;
  BlockFriendErrorState(this.error);
}