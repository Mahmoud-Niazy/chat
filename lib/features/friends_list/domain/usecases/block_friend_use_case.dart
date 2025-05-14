import 'package:chat/features/friends_list/domain/repos/friends_list_repo.dart';

class BlockFriendUseCase {
  final FriendsListRepo friendsListRepo;
  BlockFriendUseCase(this.friendsListRepo);

  Future<void> execute(String userId) async{
    await friendsListRepo.blockFriend(userId);
  }
}