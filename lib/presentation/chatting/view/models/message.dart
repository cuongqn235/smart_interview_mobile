enum MessageSender { user, ai }

class Message {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'sender': sender.toString(),
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      text: json['text'],
      sender: json['sender'] == 'MessageSender.user' 
          ? MessageSender.user 
          : MessageSender.ai,
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}