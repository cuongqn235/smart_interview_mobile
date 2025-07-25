import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_interview/core/components/dimens_widget.dart';
import 'package:smart_interview/core/config/app_router.dart';
import 'package:smart_interview/i18n/strings.g.dart';
import 'package:smart_interview/presentation/auth/bloc/auth_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _FeatureItem {
  final String text;
  final IconData icon;

  _FeatureItem({required this.text, required this.icon});
}

// Data Models
class _OnboardingStep {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final LinearGradient gradient;
  final LinearGradient bgGradient;
  final List<_FeatureItem> features;
  final Map<String, String> stats;

  _OnboardingStep({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.bgGradient,
    required this.features,
    required this.stats,
  });
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  int currentStep = 0;
  late AnimationController _slideController;
  late AnimationController _backgroundController;
  late Animation<double> _slideAnimation;

  List<_OnboardingStep> get steps => [
        _OnboardingStep(
          title: t.welcome.step1.title,
          subtitle: t.welcome.step1.subtitle,
          description: t.welcome.step1.description,
          icon: Icons.work_outline,
          gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF4F46E5)]),
          bgGradient: const LinearGradient(
              colors: [Color(0xFFEFF6FF), Color(0xFFE0E7FF)]),
          features: [
            _FeatureItem(
                text: t.welcome.step1.features[0], icon: Icons.psychology),
            _FeatureItem(
                text: t.welcome.step1.features[1], icon: Icons.track_changes),
            _FeatureItem(
                text: t.welcome.step1.features[2], icon: Icons.work_outline),
          ],
          stats: {'users': '10K+', 'success': '95%', 'questions': '500+'},
        ),
        _OnboardingStep(
          title: t.welcome.step2.title,
          subtitle: t.welcome.step2.subtitle,
          description: t.welcome.step2.description,
          icon: Icons.psychology,
          gradient: const LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)]),
          bgGradient: const LinearGradient(
              colors: [Color(0xFFFAF5FF), Color(0xFFFDF2F8)]),
          features: [
            _FeatureItem(text: t.welcome.step2.features[0], icon: Icons.star),
            _FeatureItem(text: t.welcome.step2.features[1], icon: Icons.groups),
            _FeatureItem(
                text: t.welcome.step2.features[2], icon: Icons.trending_up),
          ],
          stats: {'categories': '15+', 'difficulty': '3', 'companies': '100+'},
        ),
        _OnboardingStep(
          title: t.welcome.step3.title,
          subtitle: t.welcome.step3.subtitle,
          description: t.welcome.step3.description,
          icon: Icons.bar_chart,
          gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)]),
          bgGradient: const LinearGradient(
              colors: [Color(0xFFECFDF5), Color(0xFFD1FAE5)]),
          features: [
            _FeatureItem(
                text: t.welcome.step3.features[0], icon: Icons.bar_chart),
            _FeatureItem(
                text: t.welcome.step3.features[1], icon: Icons.emoji_events),
            _FeatureItem(
                text: t.welcome.step3.features[2], icon: Icons.trending_up),
          ],
          stats: {'accuracy': '98%', 'insights': '50+', 'tracking': '24/7'},
        ),
        _OnboardingStep(
          title: t.welcome.step4.title,
          subtitle: t.welcome.step4.subtitle,
          description: t.welcome.step4.description,
          icon: Icons.mic,
          gradient: const LinearGradient(
              colors: [Color(0xFFF97316), Color(0xFFDC2626)]),
          bgGradient: const LinearGradient(
              colors: [Color(0xFFFFF7ED), Color(0xFFFEF2F2)]),
          features: [
            _FeatureItem(text: t.welcome.step4.features[0], icon: Icons.mic),
            _FeatureItem(text: t.welcome.step4.features[1], icon: Icons.edit),
            _FeatureItem(
                text: t.welcome.step4.features[2], icon: Icons.auto_awesome),
          ],
          stats: {'modes': '2', 'quality': 'HD', 'support': '24/7'},
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final step = steps[currentStep];

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          login: (state) => appRouter.go('/login'),
          onboarding: (state) => appRouter.go('/welcome'),
          authenticated: (state) => appRouter.go('/dashboard'),
          initial: (state) => appRouter.go('/welcome'),
        );
      },
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(gradient: step.bgGradient),
          child: Stack(
            children: [
              // Animated Background Elements
              _buildBackgroundElements(),

              // Main Content
              SafeArea(
                child: Column(
                  children: [
                    // Header with Progress
                    _buildHeader(),
                    dimen16,
                    // Main Content
                    Expanded(
                      child: AnimatedBuilder(
                        animation: _slideAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _slideAnimation.value,
                            child: Transform.translate(
                              offset:
                                  Offset(0, 50 * (1 - _slideAnimation.value)),
                              child: _buildStepContent(step),
                            ),
                          );
                        },
                      ),
                    ),

                    // Navigation
                    _buildNavigation(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );
    _slideController.forward();
  }

  Widget _buildBackgroundElements() {
    return AnimatedBuilder(
      animation: _backgroundController,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: -40,
              right: -40,
              child: Transform.rotate(
                angle: _backgroundController.value * 2 * math.pi * 0.1,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: -40,
              child: Transform.rotate(
                angle: -_backgroundController.value * 2 * math.pi * 0.15,
                child: Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Sparkles
            Positioned(
              top: 80,
              right: 80,
              child: Transform.scale(
                scale: 1 +
                    0.3 * math.sin(_backgroundController.value * 2 * math.pi),
                child: Icon(
                  Icons.auto_awesome,
                  color: Colors.white.withOpacity(0.3),
                  size: 24,
                ),
              ),
            ),
            Positioned(
              bottom: 128,
              left: 64,
              child: Transform.scale(
                scale: 1 +
                    0.2 *
                        math.sin(_backgroundController.value * 2 * math.pi + 1),
                child: Icon(
                  Icons.auto_awesome,
                  color: Colors.white.withOpacity(0.2),
                  size: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFeaturesCard(_OnboardingStep step) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: step.features.map((feature) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: step.gradient,
                  ),
                  child: Icon(
                    feature.icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                dimen16,
                Expanded(
                  child: Text(
                    feature.text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF10B981),
                  size: 20,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Progress Indicators
          Row(
            children: List.generate(steps.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 8),
                height: 8,
                width: index == currentStep
                    ? 48
                    : index < currentStep
                        ? 32
                        : 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: index == currentStep
                      ? const LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)])
                      : index < currentStep
                          ? const LinearGradient(
                              colors: [Color(0xFF10B981), Color(0xFF059669)])
                          : null,
                  color: index < currentStep
                      ? null
                      : Colors.white.withOpacity(0.3),
                ),
              );
            }),
          ),

          // Skip Button
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.setFirstLaunch());
            },
            child: Text(
              t.welcome.skip,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconSection(_OnboardingStep step) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Glow effect
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: step.gradient,
            boxShadow: [
              BoxShadow(
                color: step.gradient.colors.first.withOpacity(0.3),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
        ),

        // Main icon container
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: step.gradient,
          ),
          child: Icon(
            step.icon,
            size: 48,
            color: Colors.white,
          ),
        ),

        // Floating accent
      ],
    );
  }

  Widget _buildNavigation() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Button
          TextButton.icon(
            onPressed: currentStep > 0 ? _previousStep : null,
            icon: const Icon(Icons.chevron_left),
            label: Text(t.welcome.previous),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black54,
            ),
          ),

          // Step indicator
          Text(
            '${currentStep + 1} / ${steps.length}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),

          // Next Button
          ElevatedButton.icon(
            onPressed: () => _nextStep(context),
            icon: const Icon(Icons.chevron_right),
            label: Text(currentStep == steps.length - 1
                ? t.welcome.getStarted
                : t.welcome.next),
            style: ElevatedButton.styleFrom(
              backgroundColor: steps[currentStep].gradient.colors.first,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(_OnboardingStep step) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: step.stats.entries.map((entry) {
          return Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => step.gradient.createShader(bounds),
                child: Text(
                  entry.value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              dimen4,
              Text(
                _getStatLabel(entry.key),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStepContent(_OnboardingStep step) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      children: [
        // Icon Section
        _buildIconSection(step),

        dimen32,

        // Text Content
        _buildTextContent(step),

        dimen32,

        // Features Card
        _buildFeaturesCard(step),

        dimen24,

        // Stats Section
        _buildStatsSection(step),
      ],
    );
  }

  Widget _buildTextContent(_OnboardingStep step) {
    return Column(
      children: [
        Text(
          step.title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        dimen16,
        ShaderMask(
          shaderCallback: (bounds) => step.gradient.createShader(bounds),
          child: Text(
            step.subtitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        dimen16,
        Text(
          step.description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _getStatLabel(String key) {
    switch (key) {
      case 'users':
        return t.welcome.step1.stats.users;
      case 'success':
        return t.welcome.step1.stats.success;
      case 'questions':
        return t.welcome.step1.stats.questions;
      case 'categories':
        return t.welcome.step2.stats.categories;
      case 'difficulty':
        return t.welcome.step2.stats.difficulty;
      case 'companies':
        return t.welcome.step2.stats.companies;
      case 'accuracy':
        return t.welcome.step3.stats.accuracy;
      case 'insights':
        return t.welcome.step3.stats.insights;
      case 'tracking':
        return t.welcome.step3.stats.tracking;
      case 'modes':
        return t.welcome.step4.stats.modes;
      case 'quality':
        return t.welcome.step4.stats.quality;
      case 'support':
        return t.welcome.step4.stats.support;
      default:
        return key;
    }
  }

  void _nextStep(BuildContext context) {
    if (currentStep < steps.length - 1) {
      _slideController.reverse().then((_) {
        setState(() {
          currentStep++;
        });
        _slideController.forward();
      });
    } else {
      context.read<AuthBloc>().add(const AuthEvent.setFirstLaunch());
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      _slideController.reverse().then((_) {
        setState(() {
          currentStep--;
        });
        _slideController.forward();
      });
    }
  }
}
