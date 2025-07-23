import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';

@freezed
sealed class MessageEntity with _$MessageEntity {
  const factory MessageEntity.end({
    required String content,
    required MessageSender sender,
    required DateTime timestamp,
    required String position,
    required String language,
  }) = MessageEntityEnd;

  const factory MessageEntity.message({
    required String content,
    required MessageSender sender,
    required DateTime timestamp,
  }) = MessageEntityMessage;
}

enum MessageSender {
  user,
  assistant;

  static MessageSender fromString(String sender) {
    return MessageSender.values.firstWhere(
      (e) => e.name == sender,
    );
  }
}
