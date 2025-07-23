import 'package:smart_interview/core/ultis/freezed_ultis.dart';
import 'package:smart_interview/domain/entities/message_entity.dart';

part 'message_request.g.dart';

@request
class MessageRequest {
  final String role;
  final String content;
  MessageRequest({required this.role, required this.content});

  factory MessageRequest.fromEntity(MessageEntity entity) => MessageRequest(
        role: entity.sender.name,
        content: entity.content,
      );

  Map<String, dynamic> toJson() => _$MessageRequestToJson(this);
}
