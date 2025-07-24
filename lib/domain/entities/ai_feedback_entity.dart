import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_feedback_entity.freezed.dart';

@freezed
sealed class AiFeedbackEntity with _$AiFeedbackEntity {
  const factory AiFeedbackEntity({
    required int id,
    required String structureFeedback,
    required String contentFeedback,
    required String keywordFeedback,
    required int overallScore,
  }) = _AiFeedbackEntity;
}
