import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_interview/presentation/auth/view/login_screen.dart';
import 'package:smart_interview/presentation/billing/view/billing_screen.dart';
import 'package:smart_interview/presentation/chatting/view/chatting_screen.dart';
import 'package:smart_interview/presentation/common_widgets/scaffold_with_nav_bar.dart';
import 'package:smart_interview/presentation/dashboard/view/dashboard_screen.dart';
import 'package:smart_interview/presentation/history/view/history_screen.dart';
import 'package:smart_interview/presentation/interview/view/interview_screen.dart';
import 'package:smart_interview/presentation/interview/view/success_screen.dart';
import 'package:smart_interview/presentation/settings/view/settings_screen.dart';
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
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
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
            GoRoute(
              path: 'interview',
              name: 'interview',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => const InterviewScreen(),
            ),
            GoRoute(
              path: 'interview-generated/:position',
              name: 'interview-generated',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => InterViewGeneratedScreen(
                position: state.pathParameters['position'] ?? '',
              ),
            ),
            GoRoute(
              path: 'history',
              name: 'history',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => const HistoryScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
          routes: [
            GoRoute(
              path: 'billing',
              name: 'billing',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => const BillingScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _shellNavigatorKey = GlobalKey<NavigatorState>();
