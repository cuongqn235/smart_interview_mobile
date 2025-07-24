import 'package:smart_interview/domain/entities/interview_question_entity.dart';
import 'package:smart_interview/domain/entities/interview_session_entity.dart';

abstract class InterviewSessionRepository {
  Future<InterviewSessionEntity> createInterviewSession(
      {required String positionDescription, String? language});

  Future<InterviewSessionEntity> createUserAnswer(
      {required int interviewSessionId,
      required List<InterviewQuestionEntity> listQuestion});
}
