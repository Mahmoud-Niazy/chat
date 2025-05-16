import 'package:chat/core/api/api_services.dart';
import 'package:chat/core/cache_helper/cache_helper.dart';
import 'package:chat/features/sent_friend_requests/domain/repos/sent_friend_requests_repo.dart';

class SentFriendRequestsRepoImp extends SentFriendRequestsRepo {
  final ApiServices apiServices;

  SentFriendRequestsRepoImp(this.apiServices);

  @override
  Future<List<Map<String, dynamic>>> getSentRequests() async {
    var res = await apiServices.getData(
      path: '/user/sent-requests',
      token: CacheHelper.token,
    );
    return res['sentRequests'].cast<Map<String, dynamic>>();
  }

  @override
  Future<void> removeSentFriendRequest(String userId) async {
    await apiServices.deleteData(
      path: '/user/cancel-friend-request/$userId',
      token: CacheHelper.token,
    );
  }
}
