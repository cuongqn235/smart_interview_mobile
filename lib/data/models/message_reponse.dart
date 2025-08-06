import 'package:smart_interview/core/ultis/freezed_ultis.dart';
import 'package:smart_interview/domain/entities/message_entity.dart';

part 'message_reponse.g.dart';

@response
class MessageReponse {
  final bool done;
  final String message;
  final String? position;
  final String? languageCode;
  MessageReponse({
    required this.done,
    required this.message,
    this.position,
    this.languageCode,
  });

  factory MessageReponse.fromJson(Map<String, dynamic> json) =>
      _$MessageReponseFromJson(json);

  MessageEntity toEntity() => !done
      ? MessageEntity.message(
          content: message,
          sender: MessageSender.assistant,
          timestamp: DateTime.now(),
        )
      : MessageEntity.end(
          content: message,
          sender: MessageSender.assistant,
          timestamp: DateTime.now(),
          position: position ?? '',
          languageCode: languageCode ?? '',
        );
}
