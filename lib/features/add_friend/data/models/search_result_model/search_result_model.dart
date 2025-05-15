class SearchResultModel {
  final String? userId;
  final String? email;
  final String? name;
  final String? userProfileImage;
  final bool? isFriend;
  final bool? isSentRequest;

  SearchResultModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.userProfileImage,
    required this.isFriend,
    required this.isSentRequest,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
      userProfileImage: json['userProfileImage'],
      isFriend: json['isFriend'],
      isSentRequest: json['isSentRequest'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'userProfileImage': userProfileImage,
      'isFriend': isFriend,
      'isSentRequest': isSentRequest,
    };
  }
}
