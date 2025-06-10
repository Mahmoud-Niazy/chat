class BlockedUserModel {
  final String? id;
  final String? name;
  final String? userProfileImage;

  BlockedUserModel({
    required this.id,
    required this.name,
    required this.userProfileImage,
  });

  factory BlockedUserModel.fromJson(Map<String, dynamic> json) {
    return BlockedUserModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      userProfileImage: json['userProfileImage'] as String?,
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
