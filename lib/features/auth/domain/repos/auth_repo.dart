abstract class AuthRepo {
  Future<Map<String,dynamic>> signIn({
    required String email,
    required String password,
  });

  Future<Map<String,dynamic>> signUp({
    required String email,
    required String password,
    required String phone ,
    required String name,
});

  Future<void> sendResetPasswordCode(String email);

  Future<void> resetPassword({
    required num code,
    required String newPassword,
    required String email,
});

}
