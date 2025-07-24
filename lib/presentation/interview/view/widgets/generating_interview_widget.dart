import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_interview/i18n/strings.g.dart';
import 'package:smart_interview/presentation/interview/bloc/interview_bloc.dart';
import 'package:smart_interview/presentation/interview/models/generation_step.dart';

import '../widgets/animated_brain.dart';

class GeneratingInterviewWidget extends StatefulWidget {
  final String position;

  const GeneratingInterviewWidget({super.key, required this.position});

  @override
  State<GeneratingInterviewWidget> createState() =>
      _GeneratingInterviewWidgetState();
}

class _FunFactsCard extends StatefulWidget {
  const _FunFactsCard();

  @override
  State<_FunFactsCard> createState() => _FunFactsCardState();
}

class _FunFactsCardState extends State<_FunFactsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late Timer _factTimer;

  int _currentFactIndex = 0;

  List<String> get _facts => [
        t.generatingInterview.funFacts[0],
        t.generatingInterview.funFacts[1],
        t.generatingInterview.funFacts[2],
      ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF8B5CF6).withOpacity(0.1),
                  const Color(0xFF3B82F6).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.generatingInterview.funFactsTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),

                // Animated fact text
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    _facts[_currentFactIndex],
                    key: ValueKey(_currentFactIndex),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _factTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    _scaleController.repeat(reverse: true);

    _factTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentFactIndex = (_currentFactIndex + 1) % _facts.length;
        });
      }
    });
  }
}

class _GeneratingInterviewWidgetState extends State<GeneratingInterviewWidget>
    with TickerProviderStateMixin {
  late AnimationController _mainAnimationController;
  late AnimationController _titleAnimationController;
  late Animation<double> _mainScaleAnimation;
  late Animation<double> _titleSlideAnimation;

  int _currentStep = -1;
  final List<int> _completedSteps = [];
  Timer? _stepTimer;

  double get _progressPercentage {
    if (_currentStep < 0) return 0.0;
    final progress = ((_completedSteps.length +
                (_currentStep >= 0 && _currentStep < _steps.length ? 0.5 : 0)) /
            _steps.length) *
        100;
    return progress.clamp(0.0, 100.0);
  }

  List<GenerationStep> get _steps => [
        GenerationStep(
          icon: Icons.search,
          title: t.generatingInterview.steps.analyzing.title,
          description: t.generatingInterview.steps.analyzing.description,
          gradient: const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
          ),
          duration: 1000,
        ),
        GenerationStep(
          icon: Icons.psychology,
          title: t.generatingInterview.steps.thinking.title,
          description: t.generatingInterview.steps.thinking.description,
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          ),
          duration: 1200,
        ),
        GenerationStep(
          icon: Icons.track_changes,
          title: t.generatingInterview.steps.optimizing.title,
          description: t.generatingInterview.steps.optimizing.description,
          gradient: const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)],
          ),
          duration: 800,
        ),
        GenerationStep(
          icon: Icons.description,
          title: t.generatingInterview.steps.completing.title,
          description: t.generatingInterview.steps.completing.description,
          gradient: const LinearGradient(
            colors: [Color(0xFFF59E0B), Color(0xFFEA580C)],
          ),
          duration: 1000,
        ),
      ];

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
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                // Main Brain Animation

                const SizedBox(height: 16),
                AnimatedBuilder(
                  animation: _mainScaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _mainScaleAnimation.value,
                      child: const AnimatedBrain(),
                    );
                  },
                ),

                const SizedBox(height: 24),

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
                              child: Text(
                                t.generatingInterview.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              t.generatingInterview.subtitle,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 18),
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
                                      fontSize: 16,
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

                const SizedBox(height: 16),

                // Progress Steps
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 500),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 16),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _steps.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
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
                                    child: _ProgressStep(
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

                // Fun Facts Card
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1500),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: const _FunFactsCard(),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Progress Bar
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 2000),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: _ProgressBar(
                          progress: _progressPercentage,
                          totalSteps: _steps.length,
                          completedSteps: _completedSteps.length,
                        ),
                      ),
                    );
                  },
                ),
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
            } else {
              _currentStep =
                  _steps.length; // Mark as finished to stop progress at 100%
            }
          });
        }
      });

      totalDelay += _steps[i].duration + 200;
      if (i == _steps.length - 1) {
        context.read<InterviewBloc>().add(InterviewEvent.animationEnded());
      }
    }
  }
}

class _ProgressBar extends StatefulWidget {
  final double progress;
  final int totalSteps;
  final int completedSteps;

  const _ProgressBar({
    required this.progress,
    required this.totalSteps,
    required this.completedSteps,
  });

  @override
  State<_ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<_ProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress info
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.generatingInterview.progress,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return Text(
                  '${_progressAnimation.value.round()}%',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                );
              },
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Progress bar
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _progressAnimation.value / 100,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void didUpdateWidget(_ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) {
      _progressAnimation = Tween<double>(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ));

      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }
}

class _ProgressStep extends StatefulWidget {
  final GenerationStep step;
  final bool isActive;
  final bool isCompleted;
  final int stepNumber;

  const _ProgressStep({
    required this.step,
    required this.isActive,
    required this.isCompleted,
    required this.stepNumber,
  });

  @override
  State<_ProgressStep> createState() => _ProgressStepState();
}

class _ProgressStepState extends State<_ProgressStep>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  Color get _backgroundColor {
    if (widget.isCompleted) {
      return const Color(0xFF10B981).withOpacity(0.1);
    } else if (widget.isActive) {
      return Colors.white.withOpacity(0.1);
    } else {
      return Colors.white.withOpacity(0.05);
    }
  }

  Color get _borderColor {
    if (widget.isCompleted) {
      return const Color(0xFF10B981).withOpacity(0.3);
    } else if (widget.isActive) {
      return Colors.white.withOpacity(0.2);
    } else {
      return Colors.white.withOpacity(0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          // Step Icon
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: widget.isCompleted
                          ? const LinearGradient(
                              colors: [Color(0xFF10B981), Color(0xFF059669)],
                            )
                          : widget.isActive
                              ? widget.step.gradient
                              : LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.1),
                                    Colors.white.withOpacity(0.1),
                                  ],
                                ),
                    ),
                    child: Icon(
                      widget.isCompleted
                          ? Icons.check_circle
                          : widget.step.icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(width: 16),

          // Step Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.step.title,
                  style: TextStyle(
                    color: widget.isCompleted
                        ? const Color(0xFF10B981)
                        : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.isCompleted
                      ? t.generatingInterview.completed
                      : widget.step.description,
                  style: TextStyle(
                    color: widget.isCompleted
                        ? const Color(0xFF10B981).withOpacity(0.8)
                        : Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Loading Animation
          if (widget.isActive && !widget.isCompleted)
            Row(
              children: List.generate(3, (index) {
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.5, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(value * 0.6),
                      ),
                    );
                  },
                );
              }),
            ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(_ProgressStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _animationController.repeat(reverse: true);
    } else if (!widget.isActive && oldWidget.isActive) {
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }
}
