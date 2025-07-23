import 'ai_feedback_entity.dart';

class UserAnswerEntity {
  final int id;
  final String answerText;
  final String audioUrl;
  final int speechSpeedWpm;
  final int fillerWordsCount;
  final AiFeedbackEntity? feedback;
  UserAnswerEntity({
    required this.id,
    required this.answerText,
    required this.audioUrl,
    required this.speechSpeedWpm,
    required this.fillerWordsCount,
    this.feedback,
  });
}
