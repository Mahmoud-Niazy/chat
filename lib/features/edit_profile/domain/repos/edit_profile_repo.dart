abstract class EditProfileRepo{

  Future<Map<String,dynamic>> getUserData();

  Future<void> updateUserData({
    required dynamic data
});

}

