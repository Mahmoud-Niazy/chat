abstract class FriendsListRepo{
  Future<List<Map<String,dynamic>>> getAllFriends();
  Future<void> deleteFriend (String userId);
  Future<void> blockFriend(String userId);
}