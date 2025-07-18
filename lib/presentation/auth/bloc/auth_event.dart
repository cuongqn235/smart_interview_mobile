part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.appLoaded() = _AppLoadedEvent;
  const factory AuthEvent.login() = _LoginEvent;
  const factory AuthEvent.setFirstLaunch() = _SetFirstLaunchEvent;
  const factory AuthEvent.started() = _StartedEvent;
}
