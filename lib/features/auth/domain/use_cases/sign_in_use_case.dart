import '../../data/models/user_registration_response_model.dart';
import '../repos/auth_repo.dart';

class SignInUseCase {
  final AuthRepo authRepo;

  SignInUseCase(this.authRepo);

  Future<UserRegistrationResponseDataModel> execute({
    required String email,
    required String password,
})async{
    var res = await authRepo.signIn(email: email, password: password);
    UserRegistrationResponseDataModel userRegistrationResponseDataModel = UserRegistrationResponseDataModel.fromJson(res);
    return userRegistrationResponseDataModel;
  }
}