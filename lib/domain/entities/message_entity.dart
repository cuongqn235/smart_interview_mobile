class MessageEntity {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final MessageType? type;

  MessageEntity({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.type,
  });

  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      id: json['id'],
      content: json['content'],
      isUser: json['isUser'],
      timestamp: DateTime.parse(json['timestamp']),
      type: json['type'] != null
          ? MessageType.values.firstWhere(
              (e) => e.toString() == json['type'],
              orElse: () => MessageType.text,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'type': type?.toString(),
    };
  }
}

enum MessageType {
  text,
  audio,
  system,
}
