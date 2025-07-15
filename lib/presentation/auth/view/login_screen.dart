import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isIos = Platform.isIOS;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surface,
              colorScheme.primary.withOpacity(0.2),
            ],
            stops: const [0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                const Spacer(flex: 2),
                Icon(
                  Icons.psychology_outlined,
                  size: 80,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'AI Interview Coach',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nâng tầm sự nghiệp của bạn qua từng buổi phỏng vấn.',
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const Spacer(flex: 3),
                if (isIos)
                  _SocialLoginButton(
                    label: 'Tiếp tục với Apple',
                    icon: const Icon(Icons.apple, color: Colors.white),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      // TODO: Implement real Apple Sign In
                      context.go('/dashboard');
                    },
                  )
                else
                  _SocialLoginButton(
                    label: 'Tiếp tục với Google',
                    icon: const Icon(Icons.g_mobiledata,
                        color: Colors.black87), // Placeholder
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    onPressed: () {
                      // TODO: Implement real Google Sign In
                      context.go('/dashboard');
                    },
                  ),
                const SizedBox(height: 16),
                Text(
                  'Bằng cách tiếp tục, bạn đồng ý với Điều khoản & Điều kiện của chúng tôi.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall
                      ?.copyWith(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
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
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 1,
          side: backgroundColor == Colors.white
              ? BorderSide(color: Colors.grey.shade300)
              : BorderSide.none,
        ),
      ),
    );
  }
}
