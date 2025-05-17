abstract class BlockedUsersRepo {
  Future<List<Map<String,dynamic>>> getBlockedUsers();
  Future<void> unblocUser(String userId);
}