import 'package:chat/features/friends_list/domain/repos/friends_list_repo.dart';

import '../../data/models/friend_model/friend_model.dart';

class GetAllFriendsUseCase {
  final FriendsListRepo friendsListRepo;
  GetAllFriendsUseCase(this.friendsListRepo);

  Future<List<FriendModel>> execute()async{
    var res = await friendsListRepo.getAllFriends();
    List<FriendModel> friends = [];
    for(var friend in res){
      friends.add(FriendModel.fromJson(friend));
    }
    return friends;
  }
}