abstract class SentFriendRequestsStates{}

class SentFriendRequestsInitialState extends SentFriendRequestsStates{}

class SentFriendRequestsErrorState extends SentFriendRequestsStates{
  final String error;
  SentFriendRequestsErrorState(this.error);
}

class GetSentFriendRequestsLoadingState extends SentFriendRequestsStates{}
class GetSentFriendRequestsSuccessfullyState extends SentFriendRequestsStates{}

class RemoveSentFriendRequestLoadingState extends SentFriendRequestsStates{}
class RemoveSentFriendRequestSuccessfullyState extends SentFriendRequestsStates{}
