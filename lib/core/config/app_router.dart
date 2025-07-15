import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_interview/presentation/auth/view/login_screen.dart';
import 'package:smart_interview/presentation/billing/view/billing_screen.dart';
import 'package:smart_interview/presentation/common_widgets/scaffold_with_nav_bar.dart';
import 'package:smart_interview/presentation/dashboard/view/dashboard_screen.dart';
import 'package:smart_interview/presentation/history/view/history_screen.dart';
import 'package:smart_interview/presentation/interview/view/feedback_screen.dart';
import 'package:smart_interview/presentation/interview/view/interview_screen.dart';
import 'package:smart_interview/presentation/settings/view/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
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
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/interview',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const InterviewScreen(),
    ),
    GoRoute(
      path: '/feedback',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const FeedbackScreen(),
    ),
    GoRoute(
      path: '/billing',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const BillingScreen(),
    ),
  ],
);
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _shellNavigatorKey = GlobalKey<NavigatorState>();
