import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:smart_interview/core/config/app_router.dart';

class FeatureItem {
  final String text;
  final IconData icon;

  FeatureItem({required this.text, required this.icon});
}

// Data Models
class OnboardingStep {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final LinearGradient gradient;
  final LinearGradient bgGradient;
  final List<FeatureItem> features;
  final Map<String, String> stats;

  OnboardingStep({
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

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  int currentStep = 0;
  late AnimationController _slideController;
  late AnimationController _backgroundController;
  late Animation<double> _slideAnimation;

  final List<OnboardingStep> steps = [
    OnboardingStep(
      title: 'Chào mừng đến với InterviewAce',
      subtitle: 'Huấn luyện viên phỏng vấn AI của bạn',
      description:
          'Trải nghiệm luyện tập phỏng vấn hoàn toàn mới với công nghệ AI tiên tiến, giúp bạn tự tin chinh phục mọi cuộc phỏng vấn.',
      icon: Icons.work_outline,
      gradient:
          const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF4F46E5)]),
      bgGradient:
          const LinearGradient(colors: [Color(0xFFEFF6FF), Color(0xFFE0E7FF)]),
      features: [
        FeatureItem(text: 'Phản hồi từ AI thông minh', icon: Icons.psychology),
        FeatureItem(
            text: 'Huấn luyện cá nhân hóa 100%', icon: Icons.track_changes),
        FeatureItem(
            text: 'Câu hỏi theo từng ngành nghề', icon: Icons.work_outline),
      ],
      stats: {'users': '10K+', 'success': '95%', 'questions': '500+'},
    ),
    OnboardingStep(
      title: 'Luyện Tập Thông Minh',
      subtitle: 'Từ cơ bản đến chuyên sâu',
      description:
          'Hệ thống câu hỏi đa dạng từ các công ty hàng đầu, được phân loại theo ngành nghề và mức độ kinh nghiệm của bạn.',
      icon: Icons.psychology,
      gradient:
          const LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)]),
      bgGradient:
          const LinearGradient(colors: [Color(0xFFFAF5FF), Color(0xFFFDF2F8)]),
      features: [
        FeatureItem(text: '500+ câu hỏi thực tế', icon: Icons.star),
        FeatureItem(text: 'Đa dạng ngành nghề', icon: Icons.groups),
        FeatureItem(text: 'Mức độ khó thích ứng', icon: Icons.trending_up),
      ],
      stats: {'categories': '15+', 'difficulty': '3', 'companies': '100+'},
    ),
    OnboardingStep(
      title: 'Phân Tích Chuyên Sâu',
      subtitle: 'Theo dõi từng bước tiến bộ',
      description:
          'Dashboard phân tích chi tiết giúp bạn hiểu rõ điểm mạnh, điểm yếu và lộ trình cải thiện cá nhân.',
      icon: Icons.bar_chart,
      gradient:
          const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF059669)]),
      bgGradient:
          const LinearGradient(colors: [Color(0xFFECFDF5), Color(0xFFD1FAE5)]),
      features: [
        FeatureItem(text: 'Theo dõi hiệu suất realtime', icon: Icons.bar_chart),
        FeatureItem(
            text: 'Đánh giá kỹ năng chi tiết', icon: Icons.emoji_events),
        FeatureItem(text: 'Báo cáo tiến độ trực quan', icon: Icons.trending_up),
      ],
      stats: {'accuracy': '98%', 'insights': '50+', 'tracking': '24/7'},
    ),
    OnboardingStep(
      title: 'Linh Hoạt & Tiện Lợi',
      subtitle: 'Luyện tập theo cách của bạn',
      description:
          'Hỗ trợ cả trả lời bằng giọng nói và văn bản, phù hợp với mọi phong cách học tập và sở thích cá nhân.',
      icon: Icons.mic,
      gradient:
          const LinearGradient(colors: [Color(0xFFF97316), Color(0xFFDC2626)]),
      bgGradient:
          const LinearGradient(colors: [Color(0xFFFFF7ED), Color(0xFFFEF2F2)]),
      features: [
        FeatureItem(text: 'Ghi âm giọng nói chất lượng cao', icon: Icons.mic),
        FeatureItem(text: 'Soạn thảo văn bản linh hoạt', icon: Icons.edit),
        FeatureItem(text: 'Chế độ luyện tập đa dạng', icon: Icons.auto_awesome),
      ],
      stats: {'modes': '2', 'quality': 'HD', 'support': '24/7'},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final step = steps[currentStep];

    return Scaffold(
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
                  const SizedBox(height: 16),
                  // Main Content
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _slideAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _slideAnimation.value,
                          child: Transform.translate(
                            offset: Offset(0, 50 * (1 - _slideAnimation.value)),
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

  Widget _buildFeaturesCard(OnboardingStep step) {
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
                const SizedBox(width: 16),
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
              appRouter.go('/login');
            },
            child: const Text(
              'Bỏ qua',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconSection(OnboardingStep step) {
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
            label: const Text('Trước'),
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
            onPressed: _nextStep,
            icon: const Icon(Icons.chevron_right),
            label: Text(
                currentStep == steps.length - 1 ? 'Bắt Đầu Ngay' : 'Tiếp Theo'),
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

  Widget _buildStatsSection(OnboardingStep step) {
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
              const SizedBox(height: 4),
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

  Widget _buildStepContent(OnboardingStep step) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      children: [
        // Icon Section
        _buildIconSection(step),

        const SizedBox(height: 32),

        // Text Content
        _buildTextContent(step),

        const SizedBox(height: 32),

        // Features Card
        _buildFeaturesCard(step),

        const SizedBox(height: 24),

        // Stats Section
        _buildStatsSection(step),
      ],
    );
  }

  Widget _buildTextContent(OnboardingStep step) {
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
        const SizedBox(height: 12),
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
        const SizedBox(height: 16),
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
        return 'Người dùng';
      case 'success':
        return 'Thành công';
      case 'questions':
        return 'Câu hỏi';
      case 'categories':
        return 'Danh mục';
      case 'difficulty':
        return 'Mức độ';
      case 'companies':
        return 'Công ty';
      case 'accuracy':
        return 'Chính xác';
      case 'insights':
        return 'Thông tin';
      case 'tracking':
        return 'Theo dõi';
      case 'modes':
        return 'Chế độ';
      case 'quality':
        return 'Chất lượng';
      case 'support':
        return 'Hỗ trợ';
      default:
        return key;
    }
  }

  void _nextStep() {
    if (currentStep < steps.length - 1) {
      _slideController.reverse().then((_) {
        setState(() {
          currentStep++;
        });
        _slideController.forward();
      });
    } else {
      appRouter.go('/login');
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
