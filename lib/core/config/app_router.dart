import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_interview/presentation/auth/view/login_screen.dart';
import 'package:smart_interview/presentation/chatting/view/chatting_screen.dart';
import 'package:smart_interview/presentation/dashboard/view/dashboard_screen.dart';
import 'package:smart_interview/presentation/interview/interview_screen.dart';
import 'package:smart_interview/presentation/splash/view/splash_screen.dart';
import 'package:smart_interview/presentation/welcome/view/welcome_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
      routes: [
        GoRoute(
          path: 'chatting',
          name: 'chatting',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const ChattingScreen(),
        ),
        // GoRoute(
        //   path: 'interview',
        //   name: 'interview',
        //   parentNavigatorKey: _rootNavigatorKey,
        //   builder: (context, state) => const InterviewScreen(
        //     position: 'Software Engineer',
        //   ),
        // ),
        GoRoute(
          path: 'interview/:position',
          name: 'interview',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => InterviewScreen(
            position: state.pathParameters['position'] ?? '',
            language: state.uri.queryParameters['language'] ?? '',
          ),
        ),
      ],
    ),
  ],
);
final _rootNavigatorKey = GlobalKey<NavigatorState>();
