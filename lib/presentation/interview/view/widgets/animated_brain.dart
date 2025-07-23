import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedBrain extends StatefulWidget {
  const AnimatedBrain({super.key});

  @override
  State<AnimatedBrain> createState() => _AnimatedBrainState();
}

class _AnimatedBrainState extends State<AnimatedBrain>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _particleController;
  late AnimationController _pulseController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 128,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulsing rings
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Outer ring
                  Transform.scale(
                    scale: 1 + (_pulseController.value * 0.3),
                    child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white
                              .withOpacity(0.2 * (1 - _pulseController.value)),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  // Inner ring
                  Transform.scale(
                    scale: 1 + ((_pulseController.value + 0.5) % 1.0 * 0.5),
                    child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1 *
                              (1 - ((_pulseController.value + 0.5) % 1.0))),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Orbiting particles
          AnimatedBuilder(
            animation: _particleController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: List.generate(8, (index) {
                  final angle = (index * 45 * math.pi / 180) +
                      (_particleController.value * 2 * math.pi);
                  final radius = 60.0;

                  return Transform.translate(
                    offset: Offset(
                      math.cos(angle) * radius,
                      math.sin(angle) * radius,
                    ),
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFBBF24), Color(0xFFEA580C)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFBBF24).withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
          ),

          // Main brain container
          AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationController.value * 2 * math.pi,
                child: Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B5CF6).withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.psychology,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _particleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _particleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }
}
