
import '../../../profile/data/models/user_model/user_model.dart';
import '../repos/edit_profile_repo.dart';

class GetUserDataForEditUseCase {
  final EditProfileRepo homeRepo;

  GetUserDataForEditUseCase(this.homeRepo);

  Future<UserModel> execute() async {
    var res = await homeRepo.getUserData();
    UserModel user = UserModel.fromJson(res);
    return user;
  }
}
