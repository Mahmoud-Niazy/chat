class FriendModel {
  final String? id;
  final String? name;
  final String? userProfileImage;

  FriendModel({
    required this.id,
    required this.name,
    required this.userProfileImage,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['_id'],
      name: json['name'],
      userProfileImage: json['userProfileImage'],
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
