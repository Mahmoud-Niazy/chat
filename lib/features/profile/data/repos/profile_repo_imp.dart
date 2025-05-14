import 'package:chat/core/api/api_services.dart';
import 'package:chat/features/profile/domain/repos/profile_repo.dart';
import '../../../../core/cache_helper/cache_helper.dart';

class ProfileRepoImp extends ProfileRepo{
  final ApiServices apiServices;

  ProfileRepoImp(this.apiServices);

  @override
  Future<Map<String, dynamic>> getUserData() async {
    var res = await apiServices.getData(
      path: '/user/data',
      token: CacheHelper.token,
    );
    return res['user'];
  }
}