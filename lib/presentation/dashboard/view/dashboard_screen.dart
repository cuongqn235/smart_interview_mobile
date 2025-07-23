import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_interview/presentation/chatting/view/widgets/animated_background.dart';
import 'package:smart_interview/presentation/dashboard/models/activity.dart';
import 'package:smart_interview/presentation/dashboard/models/feature.dart';
import 'package:smart_interview/presentation/dashboard/models/stat.dart';

import 'widgets/activity_card.dart';
import 'widgets/feature_card.dart';
import 'widgets/stat_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerAnimationController;
  late AnimationController _brainRotationController;
  late AnimationController _shimmerController;
  late Animation<double> _headerSlideAnimation;
  late Animation<double> _brainRotationAnimation;
  late Animation<double> _shimmerAnimation;

  int _currentMessageIndex = 0;
  Timer? _messageTimer;

  final List<String> _welcomeMessages = [
    "Chào mừng đến với AI Interview Coach! 👋",
    "Chuẩn bị phỏng vấn thông minh với AI 🚀",
    "Luyện tập, nhận phản hồi, thành công! ✨",
  ];

  final List<Feature> _features = [
    Feature(
      icon: Icons.chat_bubble_outline,
      title: "Chat thông minh",
      description: "Trò chuyện tự nhiên với AI để xác định vị trí phỏng vấn",
      gradient: const LinearGradient(
        colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
      ),
    ),
    Feature(
      icon: Icons.mic,
      title: "Ghi âm thực tế",
      description: "Trả lời bằng giọng nói như phỏng vấn thật",
      gradient: const LinearGradient(
        colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
      ),
    ),
    Feature(
      icon: Icons.bar_chart,
      title: "Phân tích AI",
      description: "Đánh giá chi tiết kỹ năng và đưa ra gợi ý cải thiện",
      gradient: const LinearGradient(
        colors: [Color(0xFF10B981), Color(0xFF059669)],
      ),
    ),
    Feature(
      icon: Icons.emoji_events,
      title: "Kết quả chi tiết",
      description: "Báo cáo toàn diện với điểm số và phản hồi",
      gradient: const LinearGradient(
        colors: [Color(0xFFF59E0B), Color(0xFFEA580C)],
      ),
    ),
  ];

  final List<Stat> _stats = [
    Stat(number: "10K+", label: "Người dùng", icon: Icons.people),
    Stat(number: "95%", label: "Thành công", icon: Icons.track_changes),
    Stat(number: "4.9", label: "Đánh giá", icon: Icons.star),
  ];

  final List<Activity> _activities = [
    Activity(user: "Minh", position: "Frontend Developer", score: 92),
    Activity(user: "Lan", position: "Product Manager", score: 88),
    Activity(user: "Hùng", position: "Data Analyst", score: 95),
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
        child: Stack(
          children: [
            // Animated background
            const AnimatedBackground(),

            // Main content
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Header
                  AnimatedBuilder(
                    animation: _headerSlideAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _headerSlideAnimation.value),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.purple.withOpacity(0.3),
                                Colors.blue.withOpacity(0.3),
                              ],
                            ),
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Animated brain icon
                              AnimatedBuilder(
                                animation: _brainRotationAnimation,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle: _brainRotationAnimation.value,
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Colors.purple, Colors.blue],
                                        ),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: const Icon(
                                        Icons.psychology,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'AI Interview Coach',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Chuẩn bị phỏng vấn thông minh',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Star rating
                              Row(
                                children: List.generate(5, (index) {
                                  return TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: Duration(
                                        milliseconds: 800 + index * 100),
                                    builder: (context, value, child) {
                                      return Transform.scale(
                                        scale: value,
                                        child: const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 12,
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Welcome message
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 600),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Colors.purple,
                                                Colors.blue
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: const Icon(
                                            Icons.auto_awesome,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            child: Text(
                                              _welcomeMessages[
                                                  _currentMessageIndex],
                                              key: ValueKey(
                                                  _currentMessageIndex),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                height: 1.4,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 24),

                          // Stats
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 800),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: Row(
                                    children:
                                        _stats.asMap().entries.map((entry) {
                                      int index = entry.key;
                                      Stat stat = entry.value;
                                      return Expanded(
                                        child: TweenAnimationBuilder<double>(
                                          tween: Tween(begin: 0.0, end: 1.0),
                                          duration: Duration(
                                              milliseconds: 1000 + index * 100),
                                          builder: (context, animValue, child) {
                                            return Transform.scale(
                                              scale: animValue,
                                              child: StatCard(stat: stat),
                                            );
                                          },
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 24),

                          // Features section
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 1000),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(-20 * (1 - value), 0),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.flash_on,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Tính năng nổi bật',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          // Features list
                          ..._features.asMap().entries.map((entry) {
                            int index = entry.key;
                            Feature feature = entry.value;
                            return TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration:
                                  Duration(milliseconds: 1200 + index * 100),
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: Offset(-20 * (1 - value), 0),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: FeatureCard(feature: feature),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),

                          const SizedBox(height: 24),

                          // Recent activity
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 1800),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Hoạt động gần đây',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    ..._activities.asMap().entries.map((entry) {
                                      int index = entry.key;
                                      Activity activity = entry.value;
                                      return TweenAnimationBuilder<double>(
                                        tween: Tween(begin: 0.0, end: 1.0),
                                        duration: Duration(
                                            milliseconds: 2000 + index * 100),
                                        builder: (context, animValue, child) {
                                          return Opacity(
                                            opacity: animValue,
                                            child: Transform.translate(
                                              offset: Offset(
                                                  -10 * (1 - animValue), 0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: ActivityCard(
                                                    activity: activity),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ],
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 200), // Space for button
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Start button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, 50 * (1 - value)),
                          child: Opacity(
                            opacity: value,
                            child: GestureDetector(
                              onTap: () => _onStartPressed(context),
                              child: AnimatedBuilder(
                                animation: _shimmerAnimation,
                                builder: (context, child) {
                                  return Container(
                                    width: double.infinity,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF7C3AED),
                                          Color(0xFF2563EB),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(28),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.purple.withOpacity(0.4),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        // Shimmer effect
                                        Positioned.fill(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(28),
                                            child: Transform.translate(
                                              offset: Offset(
                                                _shimmerAnimation.value * 200,
                                                0,
                                              ),
                                              child: Container(
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.white
                                                          .withOpacity(0.2),
                                                      Colors.transparent,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Button content
                                        const Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.chat_bubble_outline,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'Bắt đầu phỏng vấn AI',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 1500),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: const Text(
                            '💡 Mẹo: Chuẩn bị sẵn CV và mô tả công việc để có trải nghiệm tốt nhất',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _brainRotationController.dispose();
    _shimmerController.dispose();
    _messageTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startMessageRotation();
  }

  void _initializeAnimations() {
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _brainRotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _headerSlideAnimation = Tween<double>(
      begin: -50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.elasticOut,
    ));

    _brainRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _brainRotationController,
      curve: Curves.linear,
    ));

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));

    _headerAnimationController.forward();
    _brainRotationController.repeat();
    _shimmerController.repeat(reverse: true);
  }

  void _onStartPressed(BuildContext context) {
    HapticFeedback.mediumImpact();
    context.pushNamed('chatting');
    // Navigate to chat screen
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
  }

  void _startMessageRotation() {
    _messageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentMessageIndex =
              (_currentMessageIndex + 1) % _welcomeMessages.length;
        });
      }
    });
  }
}
