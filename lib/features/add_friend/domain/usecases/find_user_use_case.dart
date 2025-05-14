import 'package:chat/features/add_friend/data/models/search_result_model/search_result_model.dart';
import 'package:chat/features/add_friend/domain/repos/add_friend_repo.dart';

class FindUserUseCase {
  final AddFriendRepo addFriendRepo;
  FindUserUseCase(this.addFriendRepo);

  Future<SearchResultModel> execute(String email)async{
    var res = await addFriendRepo.findUser(email);
      SearchResultModel user = SearchResultModel.fromJson(res);
      return user;
  }
}