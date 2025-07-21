import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_interview/core/config/app_router.dart';
import 'package:smart_interview/core/config/app_theme.dart';
import 'package:smart_interview/firebase_options_dev.dart' as dev;
import 'package:smart_interview/firebase_options_prod.dart' as prod;
import 'package:smart_interview/presentation/auth/bloc/auth_bloc.dart';

import 'core/di/injectable.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
          title: 'AI Interview Coach',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
