import 'package:chat/features/blocked_users/domain/repos/blocked_users_repo.dart';

class UnblockUserUseCase {
  final BlockedUsersRepo blockedUsersRepo;

  UnblockUserUseCase(this.blockedUsersRepo);

  Future<void> execute(String userId) async {
    await blockedUsersRepo.unblocUser(userId);
  }
}
