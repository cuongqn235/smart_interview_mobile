import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_interview/data/models/base_response.dart';
import 'package:smart_interview/data/models/interview_session_creation_request.dart';
import 'package:smart_interview/data/models/interview_session_response.dart';

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
}
