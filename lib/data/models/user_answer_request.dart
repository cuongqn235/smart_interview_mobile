import 'package:smart_interview/core/ultis/freezed_ultis.dart';

part 'user_answer_request.g.dart';

@request
class UserAnswerRequest {
  final int questionId;
  final String answerText;
  UserAnswerRequest({
    required this.questionId,
    required this.answerText,
  });
  factory UserAnswerRequest.fromEntity(int questionId, String answerText) =>
      UserAnswerRequest(
        questionId: questionId,
        answerText: answerText,
      );

  Map<String, dynamic> toJson() => _$UserAnswerRequestToJson(this);
}
