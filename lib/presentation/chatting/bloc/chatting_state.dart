part of 'chatting_bloc.dart';

@freezed
sealed class ChattingState with _$ChattingState {
  const factory ChattingState({
    @Default([]) List<MessageEntity> messages,
    @Default(false) bool isTyping,
    @Default(0) int currentStep,
    String? languageCode,
  }) = _ChattingState;
}
