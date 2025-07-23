part of 'interview_bloc.dart';

@freezed
sealed class InterviewState with _$InterviewState {
  const factory InterviewState({
    @Default(Status.idle()) Status status,
    InterviewSessionEntity? interviewSession,
  }) = _InterviewState;
}
