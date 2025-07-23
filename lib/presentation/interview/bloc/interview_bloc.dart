import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_interview/core/models/status.dart';
import 'package:smart_interview/domain/entities/interview_session_entity.dart';
import 'package:smart_interview/domain/repositories/interview_session_repo.dart';

part 'interview_bloc.freezed.dart';
part 'interview_event.dart';
part 'interview_state.dart';

@injectable
class InterviewBloc extends Bloc<InterviewEvent, InterviewState> {
  final InterviewSessionRepository _interviewSessionRepo;
  InterviewBloc(this._interviewSessionRepo) : super(const InterviewState()) {
    on<_Started>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading()));
        final interviewSession =
            await _interviewSessionRepo.createInterviewSession(
          positionDescription: event.position,
          language: event.language,
        );
        emit(state.copyWith(
          status: Status.success(),
          interviewSession: interviewSession,
        ));
      } catch (e) {
        emit(state.copyWith(status: Status.error(error: e)));
      }
    });
  }
}
