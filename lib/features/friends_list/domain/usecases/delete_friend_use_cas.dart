import 'package:chat/features/friends_list/domain/repos/friends_list_repo.dart';

class DeleteFriendUseCase {
  final FriendsListRepo friendsListRepo;
  DeleteFriendUseCase(this.friendsListRepo);

  Future<void> execute(String userId) async{
    await friendsListRepo.deleteFriend(userId);
  }
}