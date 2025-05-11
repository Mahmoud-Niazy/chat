import '../../data/models/user_registration_response_model.dart';
import '../repos/auth_repo.dart';

class SignUpUseCase {
  final AuthRepo authRepo;

  SignUpUseCase(this.authRepo);

  Future<UserRegistrationResponseDataModel> execute({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) async {
    var res = await authRepo.signUp(
      email: email,
      password: password,
      phone: phone,
      name: name,
    );
    UserRegistrationResponseDataModel userRegistrationResponseDataModel = UserRegistrationResponseDataModel.fromJson(res);
    return userRegistrationResponseDataModel;
  }
}
