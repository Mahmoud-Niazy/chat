class UserModel {
  final String? name;
  final String? email;
  final String? phone;
  final String? userId;
  final String? image;
  final bool? isEmailVerified;
  final bool? isPhoneVerified;


  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.userId,
    required this.image,
    required this.isEmailVerified,
    required this.isPhoneVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      userId: json['userId'],
      isEmailVerified: json['isEmailVerified'],
      isPhoneVerified: json['isPhoneVerified'],
      image: json['userProfileImage'],
    );
  }
}
