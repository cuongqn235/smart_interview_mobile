import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_interview/core/config/app_router.dart';
import 'package:smart_interview/core/theme/colors.dart';
import 'package:smart_interview/presentation/auth/bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _elementsController;
  late AnimationController _rotationController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elementsAnimation;
  late Animation<double> _rotationAnimation;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoaded) {
          state.map(
            authenticated: (state) => appRouter.go('/dashboard'),
            onboarding: (state) => appRouter.go('/welcome'),
            login: (state) => appRouter.go('/login'),
            initial: (state) {},
          );
        }
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
            gradient: AppColors.splashGradient,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Animated Background Elements
              _buildBackgroundElements(),

              // Main Content
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - _fadeAnimation.value)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo Container
                          _buildLogoContainer(),

                          const SizedBox(height: 32),

                          // App Name
                          _buildAppName(),

                          const SizedBox(height: 24),

                          // Feature Highlights
                          _buildFeatureHighlights(),

                          const SizedBox(height: 32),

                          // Loading Animation
                          _buildLoadingAnimation(),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Bottom Stats
              _buildBottomStats(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _elementsController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _elementsController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Initialize animations
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _elementsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _elementsController, curve: Curves.easeOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(const AuthEvent.started());
      _startAnimationSequence(context);
    });
  }

  Widget _buildAppName() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFFDDD6FE), Color(0xFFC4B5FD)],
          ).createShader(bounds),
          child: const Text(
            'Smart Interview',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -1,
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _elementsAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _elementsAnimation.value,
              child: Column(
                children: [
                  Text(
                    'Làm Chủ Kỹ Năng Phỏng Vấn',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade100,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Với Công Nghệ AI Tiên Tiến',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.indigo.shade200,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        // Floating orbs
        Positioned(
          top: 80,
          left: 40,
          child: AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value * 0.5,
                child: Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.blue.withOpacity(0.2),
                        Colors.purple.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        Positioned(
          top: 160,
          right: 64,
          child: AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 10 * math.sin(_rotationAnimation.value)),
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.pink.withOpacity(0.2),
                        Colors.red.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Sparkle effects
        AnimatedBuilder(
          animation: _elementsAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _elementsAnimation.value,
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.3,
                    right: MediaQuery.of(context).size.width * 0.3,
                    child: Icon(
                      Icons.auto_awesome,
                      color: Colors.yellow.withOpacity(0.6),
                      size: 16,
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.4,
                    left: MediaQuery.of(context).size.width * 0.25,
                    child: Icon(
                      Icons.auto_awesome,
                      color: Colors.blue.withOpacity(0.6),
                      size: 12,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomStats() {
    return AnimatedBuilder(
      animation: _elementsAnimation,
      builder: (context, child) {
        return Positioned(
          bottom: 32,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: _elementsAnimation.value * 0.8,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - _elementsAnimation.value)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('10K+', 'Người dùng'),
                  _buildStatItem('500+', 'Câu hỏi'),
                  _buildStatItem('95%', 'Thành công'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureHighlights() {
    return AnimatedBuilder(
      animation: _elementsAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _elementsAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _elementsAnimation.value)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureItem(
                    Icons.psychology, 'AI Thông Minh', Colors.blue.shade300),
                _buildFeatureItem(
                    Icons.track_changes, 'Cá Nhân Hóa', Colors.green.shade300),
                _buildFeatureItem(
                    Icons.auto_awesome, 'Hiệu Quả Cao', Colors.yellow.shade300),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.blue.shade200,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingAnimation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            final delay = index * 0.2;
            final animationValue = (_rotationAnimation.value + delay) % 1.0;
            final bounce = math.sin(animationValue * 2 * math.pi).abs();

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Transform.translate(
                offset: Offset(0, -10 * bounce),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        [Colors.blue.shade400, Colors.purple.shade400],
                        [Colors.purple.shade400, Colors.pink.shade400],
                        [Colors.pink.shade400, Colors.red.shade400],
                      ][index],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildLogoContainer() {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Glow effect
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),

              // Main logo container
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Color(0xFFDBEAFE)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.work_outline,
                  size: 56,
                  color: Color(0xFF4F46E5), // indigo-600
                ),
              ),

              // Floating accent icons
              Positioned(
                top: -12,
                right: -12,
                child: AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset:
                          Offset(0, 5 * math.sin(_rotationAnimation.value * 2)),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.flash_on,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Additional floating elements
              AnimatedBuilder(
                animation: _elementsAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _elementsAnimation.value,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const SizedBox(
                          width: 112,
                          height: 112,
                        ),
                        Positioned(
                          bottom: -8,
                          left: -8,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFF10B981), Color(0xFF059669)],
                              ),
                            ),
                            child: const Icon(
                              Icons.psychology,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -4,
                          left: -12,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFFF472B6), Color(0xFFEC4899)],
                              ),
                            ),
                            child: const Icon(
                              Icons.track_changes,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.blue.shade200,
          ),
        ),
      ],
    );
  }

  void _startAnimationSequence(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _fadeController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _scaleController.forward();

    await Future.delayed(const Duration(milliseconds: 1000));
    _elementsController.forward();

    // Complete after 2.5 seconds
    await Future.delayed(const Duration(milliseconds: 1500));
    if (context.mounted) {
      context.read<AuthBloc>().add(const AuthEvent.appLoaded());
    }
  }
}
