import 'package:freezed_annotation/freezed_annotation.dart';

import 'interview_question_entity.dart';

part 'interview_session_entity.freezed.dart';

@freezed
sealed class InterviewSessionEntity with _$InterviewSessionEntity {
  const factory InterviewSessionEntity({
    required int id,
    required String positionDescription,
    required String positionParsed,
    required DateTime startedAt,
    DateTime? endedAt,
    String? notes,
    required List<InterviewQuestionEntity> questions,
  }) = _InterviewSessionEntity;
}
