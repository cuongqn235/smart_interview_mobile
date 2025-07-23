import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_interview/data/models/base_response.dart';
import 'package:smart_interview/data/models/message_reponse.dart';
import 'package:smart_interview/data/models/message_request.dart';

part 'chatting_remote_data_source.g.dart';

@RestApi()
@lazySingleton
abstract class ChattingRemoteDataSource {
  @factoryMethod
  factory ChattingRemoteDataSource(Dio dio, {String? baseUrl}) =
      _ChattingRemoteDataSource;

  @POST('/chat/message')
  Future<BaseResponse<MessageReponse>> sendMessage(
      @Body() List<MessageRequest> request);
}
