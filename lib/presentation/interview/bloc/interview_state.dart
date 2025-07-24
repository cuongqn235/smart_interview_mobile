part of 'interview_bloc.dart';

@freezed
sealed class InterviewState with _$InterviewState {
  const factory InterviewState({
    @Default(Status.idle()) Status status,
    InterviewSessionEntity? interviewSession,
    @Default(InterviewStatus.generating) InterviewStatus interviewStatus,
    @Default('en_US') String language,
  }) = _InterviewState;
}

enum InterviewStatus {
  generating,
  generated,
  interview,
  feedback,
}
