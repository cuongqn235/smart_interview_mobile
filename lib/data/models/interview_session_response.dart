import 'package:smart_interview/core/ultis/freezed_ultis.dart';
import 'package:smart_interview/data/models/interview_question_response.dart';
import 'package:smart_interview/domain/entities/interview_session_entity.dart';

part 'interview_session_response.g.dart';

@response
class InterviewSessionResponse {
  final int id;
  final String positionDescription;
  final String positionParsed;
  final DateTime startedAt;
  final DateTime endedAt;
  final String notes;
  final List<InterviewQuestionResponse> questions;
  InterviewSessionResponse({
    required this.id,
    required this.positionDescription,
    required this.positionParsed,
    required this.startedAt,
    required this.endedAt,
    required this.notes,
    required this.questions,
  });

  factory InterviewSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$InterviewSessionResponseFromJson(json);

  InterviewSessionEntity toEntity() => InterviewSessionEntity(
        id: id,
        positionDescription: positionDescription,
        positionParsed: positionParsed,
        startedAt: startedAt,
        endedAt: endedAt,
        notes: notes,
        questions: questions.map((e) => e.toEntity()).toList(),
      );
}
