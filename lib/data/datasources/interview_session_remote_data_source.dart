import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_interview/data/models/base_response.dart';
import 'package:smart_interview/data/models/interview_session_creation_request.dart';
import 'package:smart_interview/data/models/interview_session_response.dart';
import 'package:smart_interview/data/models/user_answer_request.dart';

part 'interview_session_remote_data_source.g.dart';

@RestApi()
@lazySingleton
abstract class InterviewSessionRemoteDataSource {
  @factoryMethod
  factory InterviewSessionRemoteDataSource(Dio dio, {String? baseUrl}) =
      _InterviewSessionRemoteDataSource;

  @POST('/interview-session')
  Future<BaseResponse<InterviewSessionResponse>> createInterviewSession(
      @Body() InterviewSessionCreationRequest request);

  @POST('/interview-session/{id}/user-answer')
  Future<BaseResponse<InterviewSessionResponse>> createUserAnswer(
      @Path('id') int id, @Body() List<UserAnswerRequest> requests);
}
