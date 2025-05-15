import '../../../../core/api/api_services.dart';
import '../../../../core/cache_helper/cache_helper.dart';
import '../../domain/repos/edit_profile_repo.dart';


class EditProfileRepoImp extends EditProfileRepo {
  final ApiServices apiServices;

  EditProfileRepoImp(
    this.apiServices,
  );

  @override
  Future<Map<String, dynamic>> getUserData() async {
    var res = await apiServices.getData(
      path: '/user/data',
      token: CacheHelper.token,
    );
    return res['user'];
  }

  @override
  Future<void> updateUserData({
    required dynamic data,
}
  ) async {
     await apiServices.postData(
       token: CacheHelper.token,
      path: '/user/data',
      data: data,
    );
  }
}
