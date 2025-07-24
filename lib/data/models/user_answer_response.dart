import 'package:smart_interview/core/ultis/freezed_ultis.dart';
import 'package:smart_interview/domain/entities/user_answer_entity.dart';

import 'ai_feedback_response.dart';

part 'user_answer_response.g.dart';

@response
class UserAnswerResponse {
  final int id;
  final String answerText;
  final String? audioUrl;
  final int? speechSpeedWpm;
  final int? fillerWordsCount;
  final AiFeedbackResponse? feedback;
  UserAnswerResponse({
    required this.id,
    required this.answerText,
    required this.audioUrl,
    required this.speechSpeedWpm,
    required this.fillerWordsCount,
    this.feedback,
  });
  factory UserAnswerResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAnswerResponseFromJson(json);

  UserAnswerEntity toEntity() => UserAnswerEntity(
        id: id,
        answerText: answerText,
        audioUrl: audioUrl,
        speechSpeedWpm: speechSpeedWpm,
        fillerWordsCount: fillerWordsCount,
        feedback: feedback?.toEntity(),
      );
}
