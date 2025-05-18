abstract class BlockedUsersStates {}

class BlockedUsersInitialState extends BlockedUsersStates{}

class BlockedUsersErrorState extends BlockedUsersStates{}

class GetBlockedUsersLoadingState extends BlockedUsersStates{}
class GetBlockedUsersSuccessState extends BlockedUsersStates{}

class UnblockUserLoadingState extends BlockedUsersStates{}
class UnblockUserSuccessState extends BlockedUsersStates{}