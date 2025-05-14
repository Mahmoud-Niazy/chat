import '../repos/auth_repo.dart';

class ResetPasswordUseCase {
  final AuthRepo authRepo;

  ResetPasswordUseCase(this.authRepo);

  Future<void> execute({
    required num code,
    required String newPassword,
    required String email,
  }) async {
    await authRepo.resetPassword(
      code: code,
      newPassword: newPassword,
      email: email,
    );
  }
}
