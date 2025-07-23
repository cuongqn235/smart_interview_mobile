import 'interview_question_entity.dart';

class InterviewSessionEntity {
  final int id;
  final String positionDescription;
  final String positionParsed;
  final DateTime startedAt;
  final DateTime endedAt;
  final String notes;
  final List<InterviewQuestionEntity> questions;
  InterviewSessionEntity({
    required this.id,
    required this.positionDescription,
    required this.positionParsed,
    required this.startedAt,
    required this.endedAt,
    required this.notes,
    required this.questions,
  });
}
