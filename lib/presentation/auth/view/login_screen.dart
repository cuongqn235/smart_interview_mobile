import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_interview/core/config/app_router.dart';
import 'package:smart_interview/core/di/injectable.dart';
import 'package:smart_interview/data/datasources/google_remote_data_source.dart';
import 'package:smart_interview/presentation/auth/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isIos = Platform.isIOS;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          authenticated: (state) => appRouter.go('/dashboard'),
          onboarding: (state) => appRouter.go('/welcome'),
          login: (state) => appRouter.go('/login'),
          initial: (state) => appRouter.go('/welcome'),
        );
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF6D5FFF), Color(0xFF46C2CB)],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    shadowColor: Colors.black.withOpacity(0.12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 36),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  colorScheme.primary,
                                  colorScheme.secondary
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(18),
                            child: const Icon(Icons.psychology_rounded,
                                size: 64, color: Colors.white),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            'AI Interview Coach',
                            textAlign: TextAlign.center,
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Nâng tầm sự nghiệp của bạn qua từng buổi phỏng vấn.',
                            textAlign: TextAlign.center,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 32),
                          if (isIos)
                            _SocialLoginButton(
                              label: 'Tiếp tục với Apple',
                              icon:
                                  const Icon(Icons.apple, color: Colors.white),
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              onPressed: () async {
                                context
                                    .read<AuthBloc>()
                                    .add(const AuthEvent.login());
                              },
                            )
                          else
                            _SocialLoginButton(
                              label: 'Tiếp tục với Google',
                              icon: const Icon(Icons.g_mobiledata,
                                  color: Colors.black87),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              onPressed: () {
                                // TODO: Implement real Google Sign In
                                // context.go('/dashboard');
                                getIt<GoogleAuthRemoteDataSource>().signIn();
                              },
                            ),
                          const SizedBox(height: 18),
                          Text(
                            'Bằng cách tiếp tục, bạn đồng ý với Điều khoản & Điều kiện của chúng tôi.',
                            textAlign: TextAlign.center,
                            style: textTheme.bodySmall
                                ?.copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
//    final GoogleSignIn signIn = GoogleSignIn.instance;
// unawaited(signIn
//     .initialize(clientId: clientId, serverClientId: serverClientId)
//     .then((_) {
//   signIn.authenticationEvents
//       .listen(_handleAuthenticationEvent)
//       .onError(_handleAuthenticationError);

//   /// This example always uses the stream-based approach to determining
//   /// which UI state to show, rather than using the future returned here,
//   /// if any, to conditionally skip directly to the signed-in state.
//   signIn.attemptLightweightAuthentication();
// }));
    // Future.delayed(const Duration(seconds: 1), () async {
    //   try {
    //     final user = await GoogleSignIn.instance.authenticate();
    //     print(user);
    //   } catch (e) {
    //     print(e);
    //   }
    // });
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  const _SocialLoginButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: icon,
        label: Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.10),
          side: backgroundColor == Colors.white
              ? BorderSide(color: Colors.grey.shade300)
              : BorderSide.none,
        ),
      ),
    );
  }
}
