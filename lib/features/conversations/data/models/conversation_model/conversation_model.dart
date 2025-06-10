class ConversationModel {
  final String id;
  final List<Participant> participants;
  final LastMessage? lastMessage;
  final String createdAt;
  final String updatedAt;

  ConversationModel({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      participants: (json['participants'] as List)
          .map((item) => Participant.fromJson(Map<String, dynamic>.from(item)))
          .toList(),
      lastMessage: json['lastMessage'] != null? LastMessage.fromJson(Map<String, dynamic>.from(json['lastMessage'])) : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Participant {
  final String id;
  final String name;
  final String userProfileImage;

  Participant({
    required this.id,
    required this.name,
    required this.userProfileImage,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'],
      name: json['name'],
      userProfileImage: json['userProfileImage'],
    );
  }
}

class LastMessage {
  final String id;
  final String from;
  final String to;
  final String text;
  final bool seen;

  LastMessage({
    required this.id,
    required this.from,
    required this.to,
    required this.text,
    required this.seen,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      text: json['text'],
      seen: json['seen'],
    );
  }
}
