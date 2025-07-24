import 'package:smart_interview/core/ultis/freezed_ultis.dart';
import 'package:smart_interview/domain/entities/interview_question_entity.dart';

import 'user_answer_response.dart';

part 'interview_question_response.g.dart';

@response
class InterviewQuestionResponse {
  final int id;
  final String questionText;
  final String questionType;
  final int orderIndex;
  final List<String>? aiTags;
  final UserAnswerResponse? answer;
  InterviewQuestionResponse({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.orderIndex,
    required this.aiTags,
    this.answer,
  });
  factory InterviewQuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$InterviewQuestionResponseFromJson(json);

  InterviewQuestionEntity toEntity() => InterviewQuestionEntity(
        id: id,
        questionText: questionText,
        questionType: questionType,
        orderIndex: orderIndex,
        aiTags: aiTags ?? [],
        answer: answer?.toEntity(),
      );
}
