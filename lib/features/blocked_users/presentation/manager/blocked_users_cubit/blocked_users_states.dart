abstract class BlockedUsersStates {}

class BlockedUsersInitialState extends BlockedUsersStates{}

class BlockedUsersErrorState extends BlockedUsersStates{
  final String error;
  BlockedUsersErrorState(this.error);
}

class GetBlockedUsersLoadingState extends BlockedUsersStates{}
class GetBlockedUsersSuccessState extends BlockedUsersStates{}

class UnblockUserLoadingState extends BlockedUsersStates{}
class UnblockUserSuccessState extends BlockedUsersStates{}