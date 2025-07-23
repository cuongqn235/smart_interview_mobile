import 'dart:async';

import 'package:flutter/material.dart';

class FunFactsCard extends StatefulWidget {
  const FunFactsCard({super.key});

  @override
  State<FunFactsCard> createState() => _FunFactsCardState();
}

class _FunFactsCardState extends State<FunFactsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late Timer _factTimer;

  int _currentFactIndex = 0;

  final List<String> _facts = [
    "AI của chúng tôi được huấn luyện trên hàng triệu câu hỏi phỏng vấn thực tế",
    "Mỗi câu hỏi được tạo ra dựa trên yêu cầu cụ thể của vị trí công việc",
    "Hệ thống sẽ điều chỉnh độ khó phù hợp với level kinh nghiệm của bạn",
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
            padding: const EdgeInsets.all(16),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lightbulb icon with rotation
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 0.2),
                  duration: const Duration(seconds: 2),
                  builder: (context, rotation, child) {
                    return Transform.rotate(
                      angle: rotation,
                      child: const Icon(
                        Icons.lightbulb,
                        color: Color(0xFFFBBF24),
                        size: 20,
                      ),
                    );
                  },
                ),

                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '💡 Bạn có biết?',
                        style: TextStyle(
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
