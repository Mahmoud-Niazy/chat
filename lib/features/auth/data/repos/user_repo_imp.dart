
import '../../../../core/api/api_services.dart';
import '../../domain/repos/auth_repo.dart';

class AuthRepoImp extends AuthRepo {
  final ApiServices apiServices;

  AuthRepoImp(this.apiServices);

  @override
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    var res = await apiServices.postData(
      path: '/auth/login',
      data: {
        "email": email,
        "password": password,
      },
    );
    return res.data;
  }

  @override
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    var res = await apiServices.postData(
      path: '/auth/register',
      data: {
        "email": email,
        "name": name,
        "password": password,
        "phone": phone
      },
    );
    return res.data;
  }

  @override
  Future<void> sendResetPasswordCode(String email) async {
    await apiServices.postData(
      path: '/auth/send-reset-code',
      data: {'email': email},
    );
  }

  @override
  Future<void> resetPassword({
    required num code,
    required String newPassword,
    required String email,
  }) async {
    await apiServices.postData(
      path: "/auth/reset-password",
      data:{
        "code": code,
        "email": email,
        "newPassword": newPassword,
      },
    );
  }
}
