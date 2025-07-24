import 'package:freezed_annotation/freezed_annotation.dart';

import 'ai_feedback_entity.dart';

part 'user_answer_entity.freezed.dart';

@freezed
sealed class UserAnswerEntity with _$UserAnswerEntity {
  const factory UserAnswerEntity({
    int? id,
    required String answerText,
    String? audioUrl,
    int? speechSpeedWpm,
    int? fillerWordsCount,
    AiFeedbackEntity? feedback,
  }) = _UserAnswerEntity;
}
