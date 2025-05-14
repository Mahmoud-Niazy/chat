import 'package:chat/features/add_friend/domain/repos/add_friend_repo.dart';

class SendFriendRequestUseCase {
  final AddFriendRepo addFriendRepo;
  SendFriendRequestUseCase(this.addFriendRepo);

  Future<void> execute(String userId)async{
    await addFriendRepo.sendFriendRequest(userId);
  }

}