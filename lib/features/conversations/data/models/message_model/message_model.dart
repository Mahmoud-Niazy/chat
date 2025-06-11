class MessageModel {
  final String id;
  final String conversationId;
  final String from;
  final String to;
  final String text;
  final bool seen;
  final String createdAt;
  final String updatedAt;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.from,
    required this.to,
    required this.text,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      text: json['text'] as String,
      seen: json['seen'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversationId': conversationId,
      'from': from,
      'to': to,
      'text': text,
      'seen': seen,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}