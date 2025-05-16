import 'package:chat/features/sent_friend_requests/domain/repos/sent_friend_requests_repo.dart';

class RemoveSentFriendRequestUseCase {
  final SentFriendRequestsRepo sentFriendRequestsRepo;

  RemoveSentFriendRequestUseCase(this.sentFriendRequestsRepo);

  Future<void> execute(String userId)async{
    await sentFriendRequestsRepo.removeSentFriendRequest(userId);
  }

}