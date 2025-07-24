// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/datasources/auth_remote_data_source.dart' as _i716;
import '../../data/datasources/chatting_remote_data_source.dart' as _i925;
import '../../data/datasources/google_remote_data_source.dart' as _i1011;
import '../../data/datasources/interview_session_remote_data_source.dart'
    as _i138;
import '../../data/datasources/user_remote_data_source.dart' as _i351;
import '../../data/repositories/app_repo_impl.dart' as _i110;
import '../../data/repositories/auth_repo_impl.dart' as _i653;
import '../../data/repositories/chatting_repo_impl.dart' as _i669;
import '../../data/repositories/interview_session_impl.dart' as _i6;
import '../../data/repositories/user_repo_impl.dart' as _i958;
import '../../domain/repositories/app_repo.dart' as _i77;
import '../../domain/repositories/auth_repo.dart' as _i92;
import '../../domain/repositories/chatting_repo.dart' as _i16;
import '../../domain/repositories/interview_session_repo.dart' as _i466;
import '../../domain/repositories/user_repo.dart' as _i1017;
import '../../presentation/auth/bloc/auth_bloc.dart' as _i476;
import '../../presentation/chatting/bloc/chatting_bloc.dart' as _i352;
import '../../presentation/interview/bloc/interview_bloc.dart' as _i1005;
import '../modules/app_module.dart' as _i781;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<String>(() => appModule.baseUrl);
    gh.factoryAsync<_i116.GoogleSignIn>(() => appModule.googleSignIn);
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i558.FlutterSecureStorage>(
        () => appModule.flutterSecureStorage);
    gh.singleton<_i361.Dio>(() => appModule.dio());
    gh.singleton<_i77.AppRepo>(() => _i110.AppRepoImpl(
          gh<_i460.SharedPreferences>(),
          gh<_i558.FlutterSecureStorage>(),
        ));
    gh.lazySingleton<_i925.ChattingRemoteDataSource>(
        () => _i925.ChattingRemoteDataSource(
              gh<_i361.Dio>(),
              baseUrl: gh<String>(),
            ));
    gh.lazySingleton<_i138.InterviewSessionRemoteDataSource>(
        () => _i138.InterviewSessionRemoteDataSource(
              gh<_i361.Dio>(),
              baseUrl: gh<String>(),
            ));
    gh.lazySingleton<_i351.UserRemoteDataSource>(
        () => _i351.UserRemoteDataSource(
              gh<_i361.Dio>(),
              baseUrl: gh<String>(),
            ));
    gh.lazySingleton<_i716.AuthRemoteDataSource>(
        () => _i716.AuthRemoteDataSource(
              gh<_i361.Dio>(),
              baseUrl: gh<String>(),
            ));
    gh.singletonAsync<_i1011.GoogleAuthRemoteDataSource>(() async =>
        _i1011.GoogleAuthRemoteDataSourceImpl(
            await getAsync<_i116.GoogleSignIn>()));
    gh.singleton<_i1017.UserRepo>(
        () => _i958.UserRepoImpl(gh<_i351.UserRemoteDataSource>()));
    gh.lazySingleton<_i466.InterviewSessionRepository>(() =>
        _i6.InterviewSessionRepositoryImpl(
            remoteDataSource: gh<_i138.InterviewSessionRemoteDataSource>()));
    gh.singletonAsync<_i92.AuthRepo>(() async => _i653.AuthRepoImpl(
          await getAsync<_i1011.GoogleAuthRemoteDataSource>(),
          gh<_i716.AuthRemoteDataSource>(),
          gh<_i77.AppRepo>(),
        ));
    gh.singletonAsync<_i476.AuthBloc>(() async => _i476.AuthBloc(
          gh<_i77.AppRepo>(),
          gh<_i1017.UserRepo>(),
          await getAsync<_i92.AuthRepo>(),
        ));
    gh.factory<_i1005.InterviewBloc>(
        () => _i1005.InterviewBloc(gh<_i466.InterviewSessionRepository>()));
    gh.lazySingleton<_i16.ChattingRepo>(
        () => _i669.ChattingRepoImpl(gh<_i925.ChattingRemoteDataSource>()));
    gh.factory<_i352.ChattingBloc>(
        () => _i352.ChattingBloc(gh<_i16.ChattingRepo>()));
    return this;
  }
}

class _$AppModule extends _i781.AppModule {}
