import 'package:chat/core/api/api_services.dart';
import 'package:chat/core/cache_helper/cache_helper.dart';
import 'package:chat/features/blocked_users/domain/repos/blocked_users_repo.dart';

class BlockedUsersRepoImp extends BlockedUsersRepo {
  final ApiServices apiServices;

  BlockedUsersRepoImp(this.apiServices);

  @override
  Future<List<Map<String, dynamic>>> getBlockedUsers() async {
    var res = await apiServices.getData(
      path: '/user/blocked',
      token: CacheHelper.token,
    );
    return res['blockedUsers'].cast<Map<String, dynamic>>();
  }

  @override
  Future<void> unblocUser(String userId) async {
    await apiServices.postData(
      path: '/user/unblock/$userId',
      data: null,
      token: CacheHelper.token,
    );
  }
}
