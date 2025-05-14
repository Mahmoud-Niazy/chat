abstract class AddFriendRepo {
  Future<void> sendFriendRequest(String userId);
  Future<Map<String,dynamic>> findUser(String email);
}