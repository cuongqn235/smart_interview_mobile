import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_interview/domain/entities/user_info_entity.dart';
import 'package:smart_interview/domain/repositories/app_repo.dart';
import 'package:smart_interview/domain/repositories/auth_repo.dart';
import 'package:smart_interview/domain/repositories/user_repo.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppRepo _appRepo;
  final UserRepo _userRepo;
  final AuthRepo _authRepo;
  AuthBloc(this._appRepo, this._userRepo, this._authRepo)
      : super(const _InitialState()) {
    on<_StartedEvent>((event, emit) async {
      try {
        final isFirstLaunch = await _appRepo.isFirstLaunch();
        if (isFirstLaunch) {
          emit(AuthState.onboarding(isLoaded: state.isLoaded));
          return;
        }
        final accessToken = await _appRepo.getAccessToken();
        if (accessToken == null) {
          emit(AuthState.login(isLoaded: state.isLoaded));
          return;
        }
        final userInfo = await _userRepo.getUserInfo();
        emit(AuthState.authenticated(user: userInfo, isLoaded: state.isLoaded));
      } catch (e) {
        emit(AuthState.login(isLoaded: state.isLoaded));
      }
    });
    on<_LoginEvent>((event, emit) async {
      try {
        final userInfo = await _authRepo.login();
        emit(AuthState.authenticated(user: userInfo, isLoaded: state.isLoaded));
      } catch (e) {
        emit(AuthState.login(isLoaded: state.isLoaded));
      }
    });
    on<_SetFirstLaunchEvent>((event, emit) async {
      try {
        await _appRepo.setFirstLaunch(false);
        emit(AuthState.login(isLoaded: state.isLoaded));
      } catch (e) {
        emit(AuthState.login(isLoaded: state.isLoaded));
      }
    });
    on<_AppLoadedEvent>((event, emit) async {
      emit(state.copyWith(isLoaded: true));
    });
  }
}
