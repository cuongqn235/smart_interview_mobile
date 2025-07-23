part of 'chatting_bloc.dart';

@freezed
sealed class ChattingEvent with _$ChattingEvent {
  const factory ChattingEvent.sendMessage(String message) = _SendMessage;
}
