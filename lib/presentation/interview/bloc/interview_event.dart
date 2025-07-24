part of 'interview_bloc.dart';

@freezed
sealed class InterviewEvent with _$InterviewEvent {
  const factory InterviewEvent.animationEnded() = _AnimationEnded;

  const factory InterviewEvent.answerChanged({
    required int questionId,
    required String answer,
  }) = _AnswerChanged;

  const factory InterviewEvent.feedbackRequested() = _FeedbackRequested;

  const factory InterviewEvent.interviewStarted() = _InterviewStarted;

  const factory InterviewEvent.started({
    required String position,
    String? language,
  }) = _Started;
}
