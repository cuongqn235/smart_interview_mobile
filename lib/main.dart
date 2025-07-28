import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:smart_interview/core/config/app_router.dart';
import 'package:smart_interview/core/config/app_theme.dart';
import 'package:smart_interview/core/di/injectable.dart';
import 'package:smart_interview/firebase_options_dev.dart' as dev;
import 'package:smart_interview/firebase_options_prod.dart' as prod;
import 'package:smart_interview/gen/assets.gen.dart';
import 'package:smart_interview/i18n/strings.g.dart';
import 'package:smart_interview/presentation/auth/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  switch (String.fromEnvironment('ENV')) {
    case 'dev':
      await Firebase.initializeApp(
          options: dev.DefaultFirebaseOptions.currentPlatform);
      await dotenv.load(fileName: "dev.env");
      break;
    case 'prod':
      await Firebase.initializeApp(
          options: prod.DefaultFirebaseOptions.currentPlatform);
      await dotenv.load(fileName: "prod.env");
      break;
    default:
      await dotenv.load(fileName: "dev.env");
  }

  await configureDependencies();
  runApp(
    TranslationProvider(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayWidgetBuilder: (context) => Center(
            child: Assets.loading.lottie(
              width: 100,
              height: 100,
            ),
          ),
          child: MaterialApp.router(
            title: 'Smart Interview',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            routerConfig: appRouter,
          ),
        ),
      ),
    );
  }
}
