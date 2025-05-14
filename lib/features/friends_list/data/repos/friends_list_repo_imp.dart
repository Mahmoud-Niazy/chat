import 'package:chat/core/api/api_services.dart';
import 'package:chat/core/cache_helper/cache_helper.dart';

import '../../domain/repos/friends_list_repo.dart';

class FriendsListRepoImp extends FriendsListRepo {
  final ApiServices apiServices;

  FriendsListRepoImp(this.apiServices);

  @override
  Future<List<Map<String, dynamic>>> getAllFriends() async {
    var res = await apiServices.getData(
      path: '/user/friends',
      token: CacheHelper.token,
    );
    return res['friends'].cast<Map<String,dynamic>>();
  }

  @override
  Future<void> deleteFriend(String userId) async {
    await apiServices.deleteData(
      path: '/user/friend/$userId',
      token: CacheHelper.token,
    );
  }

  @override
  Future<void> blockFriend(String userId) async {
    await apiServices.postData(
      path: '/user/block/$userId',
      data: {},
      token: CacheHelper.token,
    );
  }
}
