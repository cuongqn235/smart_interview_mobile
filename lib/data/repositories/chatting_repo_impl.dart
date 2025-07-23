import 'package:injectable/injectable.dart';
import 'package:smart_interview/data/datasources/chatting_remote_data_source.dart';
import 'package:smart_interview/data/models/base_response.dart';
import 'package:smart_interview/data/models/message_request.dart';
import 'package:smart_interview/domain/entities/message_entity.dart';
import 'package:smart_interview/domain/repositories/chatting_repo.dart';

@LazySingleton(as: ChattingRepo)
class ChattingRepoImpl implements ChattingRepo {
  final ChattingRemoteDataSource _chattingRemoteDataSource;

  ChattingRepoImpl(this._chattingRemoteDataSource);

  @override
  Future<MessageEntity> sendMessage(List<MessageEntity> messages) async {
    final response = await _chattingRemoteDataSource.sendMessage(
      messages.map(MessageRequest.fromEntity).toList(),
    );
    return response.onResult(
      (data) => data.toEntity(),
      onError: (error) => throw Exception(error),
    );
  }
}
