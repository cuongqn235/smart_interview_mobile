import 'package:smart_interview/domain/entities/message_entity.dart';

abstract class ChattingRepo {
  Future<MessageEntity> sendMessage(List<MessageEntity> messages,
      {String? languageCode});
}
