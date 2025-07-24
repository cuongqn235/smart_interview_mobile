import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_answer_entity.dart';

part 'interview_question_entity.freezed.dart';

@freezed
sealed class InterviewQuestionEntity with _$InterviewQuestionEntity {
  const factory InterviewQuestionEntity({
    required int id,
    required String questionText,
    required String questionType,
    required int orderIndex,
    required List<String> aiTags,
    UserAnswerEntity? answer,
  }) = _InterviewQuestionEntity;
}
