part of 'auth_bloc.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.authenticated({
    required UserInfoEntity user,
    @Default(false) bool isLoaded,
  }) = _AuthenticatedState;
  const factory AuthState.initial({
    @Default(false) bool isLoaded,
  }) = _InitialState;
  const factory AuthState.login({
    @Default(false) bool isLoaded,
  }) = _LoginState;
  const factory AuthState.onboarding({
    @Default(false) bool isLoaded,
  }) = _OnboardingState;
}

extension AuthStateX on AuthState {
  UserInfoEntity get userInfo => maybeMap(
        authenticated: (state) => state.user,
        orElse: () => throw UnimplementedError(),
      );
}
