import 'package:smart_interview/domain/entities/interview_session_entity.dart';

abstract class InterviewSessionRepository {
  Future<InterviewSessionEntity> createInterviewSession(
      {required String positionDescription, String? language});
}
