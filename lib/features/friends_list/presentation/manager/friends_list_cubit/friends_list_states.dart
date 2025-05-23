abstract class FriendsListStates {}

class FriendsListInitialState extends FriendsListStates{}

class FriendsListErrorState extends FriendsListStates{
  final String error;
  FriendsListErrorState(this.error);
}


class GetFriendsListLoadingState extends FriendsListStates{}
class GetFriendsListSuccessfullyState extends FriendsListStates{}


class DeleteFriendLoadingState extends FriendsListStates{}
class DeleteFriendSuccessfullyState extends FriendsListStates{}

class BlockFriendLoadingState extends FriendsListStates{}
class BlockFriendSuccessfullyState extends FriendsListStates{}
