part of 'interview_bloc.dart';

@freezed
sealed class InterviewEvent with _$InterviewEvent {
  const factory InterviewEvent.started({
    required String position,
    String? language,
  }) = _Started;
}
