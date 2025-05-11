class UserRegistrationResponseDataModel {

  final String name;
  final String email;
  final String phone;
  final String userId;
  final String image;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final String? accessToken;

  UserRegistrationResponseDataModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.userId,
    required this.image,
    required this.isEmailVerified,
    this.accessToken,
    required this.isPhoneVerified,
  });

  factory UserRegistrationResponseDataModel.fromJson(Map<String, dynamic> json) {
    return UserRegistrationResponseDataModel(
      name: json['user']['name'],
      phone: json['user']['phone'],
      email: json['user']['email'],
      userId: json['user']['userId'],
      accessToken: json['accessToken'],
      isEmailVerified: json['user']['isEmailVerified'],
      isPhoneVerified: json['user']['isPhoneVerified'],
      image: json['user']['userProfileImage'],
    );
  }
}
