import 'package:smart_interview/core/ultis/freezed_ultis.dart';
import 'package:smart_interview/domain/entities/ai_feedback_entity.dart';

part 'ai_feedback_response.g.dart';

@response
class AiFeedbackResponse {
  final int id;
  final String structureFeedback;
  final String contentFeedback;
  final String keywordFeedback;
  final int overallScore;
  AiFeedbackResponse({
    required this.id,
    required this.structureFeedback,
    required this.contentFeedback,
    required this.keywordFeedback,
    required this.overallScore,
  });
  factory AiFeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$AiFeedbackResponseFromJson(json);

  AiFeedbackEntity toEntity() => AiFeedbackEntity(
        id: id,
        structureFeedback: structureFeedback,
        contentFeedback: contentFeedback,
        keywordFeedback: keywordFeedback,
        overallScore: overallScore,
      );
}
