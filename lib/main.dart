import 'package:flutter/material.dart';
import 'package:smart_interview/core/config/app_router.dart';
import 'package:smart_interview/core/config/app_theme.dart';

void main() {
  // TODO: Add DI setup: configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AI Interview Coach',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
