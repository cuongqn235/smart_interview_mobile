import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_interview/core/di/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() => getIt.init();
