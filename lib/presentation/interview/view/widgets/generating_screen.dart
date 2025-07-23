import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_interview/presentation/interview/models/generation_step.dart';
import 'package:smart_interview/presentation/interview/models/progress_step.dart';

import '../widgets/animated_brain.dart';
import '../widgets/fun_facts_card.dart';
import '../widgets/progress_bar.dart';

class GeneratingScreen extends StatefulWidget {
  final String position;

  const GeneratingScreen({super.key, required this.position});

  @override
  State<GeneratingScreen> createState() => _GeneratingScreenState();
}

class _GeneratingScreenState extends State<GeneratingScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainAnimationController;
  late AnimationController _titleAnimationController;
  late Animation<double> _mainScaleAnimation;
  late Animation<double> _titleSlideAnimation;

  int _currentStep = -1;
  final List<int> _completedSteps = [];
  Timer? _stepTimer;

  final List<GenerationStep> _steps = [
    GenerationStep(
      icon: Icons.search,
      title: "Phân tích vị trí",
      description: "Đang phân tích yêu cầu công việc...",
      gradient: const LinearGradient(
        colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
      ),
      duration: 1000,
    ),
    GenerationStep(
      icon: Icons.psychology,
      title: "AI suy nghĩ",
      description: "Đang tạo câu hỏi phù hợp...",
      gradient: const LinearGradient(
        colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
      ),
      duration: 1200,
    ),
    GenerationStep(
      icon: Icons.track_changes,
      title: "Tối ưu hóa",
      description: "Đang tối ưu độ khó và relevance...",
      gradient: const LinearGradient(
        colors: [Color(0xFF10B981), Color(0xFF059669)],
      ),
      duration: 800,
    ),
    GenerationStep(
      icon: Icons.description,
      title: "Hoàn thiện",
      description: "Đang hoàn thiện bộ câu hỏi...",
      gradient: const LinearGradient(
        colors: [Color(0xFFF59E0B), Color(0xFFEA580C)],
      ),
      duration: 1000,
    ),
  ];

  double get _progressPercentage {
    if (_currentStep < 0) return 0.0;
    return ((_completedSteps.length + (_currentStep >= 0 ? 0.5 : 0)) /
            _steps.length) *
        100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(),

                // Main Brain Animation
                AnimatedBuilder(
                  animation: _mainScaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _mainScaleAnimation.value,
                      child: const AnimatedBrain(),
                    );
                  },
                ),

                const SizedBox(height: 32),

                // Title Section
                AnimatedBuilder(
                  animation: _titleSlideAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _titleSlideAnimation.value),
                      child: Opacity(
                        opacity: _titleAnimationController.value,
                        child: Column(
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFFA855F7), Color(0xFF3B82F6)],
                              ).createShader(bounds),
                              child: const Text(
                                'Đang tạo câu hỏi... 🤖',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Cho vị trí',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 1.0, end: 1.05),
                              duration: const Duration(seconds: 2),
                              builder: (context, scale, child) {
                                return Transform.scale(
                                  scale: scale,
                                  child: Text(
                                    '"${widget.position}"',
                                    style: const TextStyle(
                                      color: Color(0xFFA855F7),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // Progress Steps
                Expanded(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - value)),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _steps.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              return TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration:
                                    Duration(milliseconds: 700 + index * 100),
                                builder: (context, animValue, child) {
                                  return Opacity(
                                    opacity: animValue,
                                    child: Transform.translate(
                                      offset: Offset(-20 * (1 - animValue), 0),
                                      child: ProgressStep(
                                        step: _steps[index],
                                        isActive: _currentStep == index,
                                        isCompleted:
                                            _completedSteps.contains(index),
                                        stepNumber: index,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 32),

                // Fun Facts Card
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1500),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: const FunFactsCard(),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Progress Bar
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 2000),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: ProgressBar(
                          progress: _progressPercentage,
                          totalSteps: _steps.length,
                          completedSteps: _completedSteps.length,
                        ),
                      ),
                    );
                  },
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mainAnimationController.dispose();
    _titleAnimationController.dispose();
    _stepTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startStepSequence();
  }

  void _initializeAnimations() {
    _mainAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _titleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _mainScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainAnimationController,
      curve: Curves.elasticOut,
    ));

    _titleSlideAnimation = Tween<double>(
      begin: 20.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _titleAnimationController,
      curve: Curves.easeOut,
    ));

    _mainAnimationController.forward();

    Timer(const Duration(milliseconds: 300), () {
      _titleAnimationController.forward();
    });
  }

  void _startStepSequence() {
    int totalDelay = 500;

    for (int i = 0; i < _steps.length; i++) {
      Timer(Duration(milliseconds: totalDelay), () {
        if (mounted) {
          setState(() {
            _currentStep = i;
          });
        }
      });

      Timer(Duration(milliseconds: totalDelay + _steps[i].duration), () {
        if (mounted) {
          setState(() {
            _completedSteps.add(i);
            if (i < _steps.length - 1) {
              _currentStep = i + 1;
            }
          });
        }
      });

      totalDelay += _steps[i].duration + 200;
    }

    // Navigate to success screen after completion
    Timer(Duration(milliseconds: totalDelay + 500), () {
      if (mounted) {
        // Navigate to success screen
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SuccessScreen()));
        print("Generation completed! Navigate to success screen.");
      }
    });
  }
}
