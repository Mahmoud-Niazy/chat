import 'package:chat/features/blocked_users/domain/repos/blocked_users_repo.dart';

import '../../data/models/blocked_user_model/blocked_user_model.dart';

class GetBlockedUsersUseCase{
  final BlockedUsersRepo blockedUsersRepo;
  GetBlockedUsersUseCase(this.blockedUsersRepo);

  Future<List<BlockedUserModel>> execute()async{
    var res = await blockedUsersRepo.getBlockedUsers();
    List<BlockedUserModel> blockedUsers = [];
    for(var user in res){
      blockedUsers.add(BlockedUserModel.fromJson(user));
    }
    return blockedUsers;
  }
}