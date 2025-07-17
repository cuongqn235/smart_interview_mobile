// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasources/auth_remote_data_source.dart' as _i716;
import '../../data/datasources/google_remote_data_source.dart' as _i1011;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../modules/app_module.dart' as _i781;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<String>(() => appModule.baseUrl);
    gh.factoryAsync<_i116.GoogleSignIn>(() => appModule.googleSignIn);
    gh.singleton<_i361.Dio>(() => appModule.dio());
    gh.lazySingleton<_i716.AuthRemoteDataSource>(
        () => _i716.AuthRemoteDataSource(
              gh<_i361.Dio>(),
              baseUrl: gh<String>(),
            ));
    gh.singletonAsync<_i1011.GoogleAuthRemoteDataSource>(() async =>
        _i1011.GoogleAuthRemoteDataSourceImpl(
            await getAsync<_i116.GoogleSignIn>()));
    gh.singletonAsync<_i1073.AuthRepository>(
        () async => _i895.AuthRepositoryImpl(
              await getAsync<_i1011.GoogleAuthRemoteDataSource>(),
              gh<_i716.AuthRemoteDataSource>(),
            ));
    return this;
  }
}

class _$AppModule extends _i781.AppModule {}
