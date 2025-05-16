class SentFriendRequestModel {
  final String? id;
  final String? name;
  final String? userProfileImage;

  SentFriendRequestModel({
    required this.id,
    required this.name,
    required this.userProfileImage,
  });

  factory SentFriendRequestModel.fromJson(Map<String, dynamic> json) {
    return SentFriendRequestModel(
      id: json['_id'] ,
      name: json['name'] ,
      userProfileImage: json['userProfileImage'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'userProfileImage': userProfileImage,
    };
  }
}
