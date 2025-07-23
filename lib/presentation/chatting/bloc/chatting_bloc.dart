import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_interview/domain/entities/message_entity.dart';
import 'package:smart_interview/domain/repositories/chatting_repo.dart';

part 'chatting_bloc.freezed.dart';
part 'chatting_event.dart';
part 'chatting_state.dart';

@injectable
class ChattingBloc extends Bloc<ChattingEvent, ChattingState> {
  final ChattingRepo _chattingRepo;

  ChattingBloc(this._chattingRepo)
      : super(ChattingState(messages: [
          MessageEntity.message(
            content:
                'Chào bạn! Tôi là AI Interview Coach. Hãy cho tôi biết vị trí công việc bạn muốn phỏng vấn nhé! 🚀',
            sender: MessageSender.assistant,
            timestamp: DateTime.now(),
          )
        ])) {
    on<_SendMessage>((event, emit) async {
      try {
        emit(state.copyWith(isTyping: true));
        final newMessages = [
          ...state.messages,
          MessageEntity.message(
            content: event.message,
            sender: MessageSender.user,
            timestamp: DateTime.now(),
          ),
        ];
        emit(state.copyWith(messages: newMessages));
        final message = await _chattingRepo.sendMessage(newMessages);
        emit(state.copyWith(
          messages: [...state.messages, message],
          isTyping: false,
        ));
      } catch (e) {
        emit(state.copyWith(isTyping: false));
      }
    });
  }
}
