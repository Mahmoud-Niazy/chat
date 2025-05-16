import 'package:chat/features/sent_friend_requests/data/models/sent_friend_request_model/sent_friend_request_model.dart';
import 'package:chat/features/sent_friend_requests/domain/repos/sent_friend_requests_repo.dart';

class GetSentFriendRequestsUseCase {
  final SentFriendRequestsRepo sentFriendRequestsRepo;
  GetSentFriendRequestsUseCase(this.sentFriendRequestsRepo);

  Future<List<SentFriendRequestModel>> execute()async{
    var res = await sentFriendRequestsRepo.getSentRequests();
    List<SentFriendRequestModel> requests = [];
    for(var request in res){
      requests.add(SentFriendRequestModel.fromJson(request));
    }
    return requests;
  }
}