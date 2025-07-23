import 'package:flutter/material.dart';

import '../models/generation_step.dart';

class ProgressStep extends StatefulWidget {
  final GenerationStep step;
  final bool isActive;
  final bool isCompleted;
  final int stepNumber;

  const ProgressStep({
    super.key,
    required this.step,
    required this.isActive,
    required this.isCompleted,
    required this.stepNumber,
  });

  @override
  State<ProgressStep> createState() => _ProgressStepState();
}

class _ProgressStepState extends State<ProgressStep>
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
      padding: const EdgeInsets.all(16),
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
                    width: 48,
                    height: 48,
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
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.isCompleted ? "Hoàn thành!" : widget.step.description,
                  style: TextStyle(
                    color: widget.isCompleted
                        ? const Color(0xFF10B981).withOpacity(0.8)
                        : Colors.white.withOpacity(0.7),
                    fontSize: 14,
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
  void didUpdateWidget(ProgressStep oldWidget) {
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
