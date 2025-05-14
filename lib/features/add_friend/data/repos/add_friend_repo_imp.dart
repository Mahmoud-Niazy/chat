import 'package:chat/core/api/api_services.dart';
import 'package:chat/core/cache_helper/cache_helper.dart';

import '../../domain/repos/add_friend_repo.dart';

class AddFriendRepoImp extends AddFriendRepo {
  final ApiServices apiServices;

  AddFriendRepoImp(this.apiServices);

  @override
  Future<void> sendFriendRequest(String userId) async {
    await apiServices.postData(
      path: '/user/friend/$userId',
      data: {},
      token: CacheHelper.token,
    );
  }

  @override
  Future<Map<String, dynamic>> findUser(String email) async {
    var res = await apiServices.getData(
      path: '/user/find/$email',
      token: CacheHelper.token,
    );
    return res['user'];
  }
}
