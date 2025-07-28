import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_interview/core/models/status.dart';
import 'package:smart_interview/domain/entities/interview_question_entity.dart';
import 'package:smart_interview/domain/entities/interview_session_entity.dart';
import 'package:smart_interview/domain/entities/user_answer_entity.dart';
import 'package:smart_interview/domain/repositories/interview_session_repo.dart';

part 'interview_bloc.freezed.dart';
part 'interview_event.dart';
part 'interview_state.dart';

@injectable
class InterviewBloc extends Bloc<InterviewEvent, InterviewState> {
  final InterviewSessionRepository _interviewSessionRepo;
  final Completer<void> _completer = Completer<void>();
  InterviewBloc(this._interviewSessionRepo) : super(const InterviewState()) {
    on<_Started>((event, emit) async {
      emit(state.copyWith(interviewStatus: InterviewStatus.generating));
      try {
        emit(state.copyWith(status: Status.loading()));
        final interviewSession =
            await _interviewSessionRepo.createInterviewSession(
          positionDescription: event.position,
          language: event.language,
        );
        if (!_completer.isCompleted) {
          await _completer.future;
        }
        emit(state.copyWith(
          interviewSession: interviewSession,
          interviewStatus: InterviewStatus.generated,
          language: event.language ?? 'vi_VN',
        ));
      } catch (e) {
        emit(state.copyWith(status: Status.error(error: e)));
      } finally {
        emit(state.copyWith(status: Status.idle()));
      }
    });

    on<_AnimationEnded>((event, emit) {
      if (!_completer.isCompleted) {
        _completer.complete();
      }
    });

    on<_InterviewStarted>((event, emit) {
      emit(state.copyWith(interviewStatus: InterviewStatus.interview));
    });

    on<_AnswerChanged>((event, emit) {
      final questions = List<InterviewQuestionEntity>.from(
          state.interviewSession?.questions ?? []);
      final question = questions.firstWhere((e) => e.id == event.questionId);
      InterviewQuestionEntity? newQuestion;
      if (question.answer == null) {
        newQuestion = question.copyWith(
            answer: UserAnswerEntity(answerText: event.answer));
      } else {
        newQuestion = question.copyWith(
            answer: question.answer!.copyWith(answerText: event.answer));
      }
      final index = questions.indexWhere((e) => e.id == event.questionId);
      if (index != -1) {
        questions[index] = newQuestion;
      } else {
        questions.add(newQuestion);
      }
      emit(state.copyWith(
          interviewSession:
              state.interviewSession?.copyWith(questions: questions)));
    });

    on<_FeedbackRequested>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading()));
        final questions = state.interviewSession?.questions ?? [];
        final response = await _interviewSessionRepo.createUserAnswer(
          interviewSessionId: state.interviewSession?.id ?? 0,
          listQuestion: questions,
        );
        emit(state.copyWith(
            status: Status.success(),
            interviewStatus: InterviewStatus.feedback,
            interviewSession: response));
      } catch (e) {
        emit(state.copyWith(status: Status.error(error: e)));
      }
    });
  }
}
