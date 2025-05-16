abstract class SentFriendRequestsRepo{
  Future<List<Map<String,dynamic>>> getSentRequests();
  Future<void> removeSentFriendRequest(String userId);
}