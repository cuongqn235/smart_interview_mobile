import 'user_answer_entity.dart';

class InterviewQuestionEntity {
  final int id;
  final String questionText;
  final String questionType;
  final int orderIndex;
  final Map<String, dynamic> aiTags;
  final UserAnswerEntity? answer;
  InterviewQuestionEntity({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.orderIndex,
    required this.aiTags,
    this.answer,
  });
}
