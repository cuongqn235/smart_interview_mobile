import 'package:injectable/injectable.dart';
import 'package:smart_interview/data/datasources/interview_session_remote_data_source.dart';
import 'package:smart_interview/data/models/base_response.dart';
import 'package:smart_interview/data/models/interview_session_creation_request.dart';
import 'package:smart_interview/data/models/user_answer_request.dart';
import 'package:smart_interview/domain/entities/interview_question_entity.dart';
import 'package:smart_interview/domain/entities/interview_session_entity.dart';
import 'package:smart_interview/domain/repositories/interview_session_repo.dart';

@LazySingleton(as: InterviewSessionRepository)
class InterviewSessionRepositoryImpl implements InterviewSessionRepository {
  final InterviewSessionRemoteDataSource remoteDataSource;

  InterviewSessionRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<InterviewSessionEntity> createInterviewSession(
      {required String positionDescription, String? language}) async {
    final response = await remoteDataSource
        .createInterviewSession(InterviewSessionCreationRequest(
      positionDescription: positionDescription,
      language: language,
    ));
    return response.onResult((data) => data.toEntity());
  }

  @override
  Future<InterviewSessionEntity> createUserAnswer(
      {required int interviewSessionId,
      required List<InterviewQuestionEntity> listQuestion}) async {
    final response = await remoteDataSource.createUserAnswer(
      interviewSessionId,
      listQuestion
          .map((e) =>
              UserAnswerRequest.fromEntity(e.id, e.answer?.answerText ?? ''))
          .toList(),
    );
    return response.onResult((data) => data.toEntity());
  }
}
