import 'package:chat/features/profile/domain/repos/profile_repo.dart';
import '../../data/models/user_model/user_model.dart';

class GetUserDataUseCase {
  final ProfileRepo profileRepo;
  GetUserDataUseCase(this.profileRepo);

  Future<UserModel> execute()async{
    var res = await profileRepo.getUserData();
    UserModel user = UserModel.fromJson(res);
    return user;
  }
}