import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6D5FFF), Color(0xFF46C2CB)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildHeader(context, 'Vu'),
              const SizedBox(height: 24),
              _buildStartInterviewCard(context),
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'Hoặc chọn lĩnh vực phổ biến'),
              const SizedBox(height: 16),
              _buildSuggestedTopics(),
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'Tiến trình của bạn'),
              const SizedBox(height: 16),
              _buildProgressCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String name) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Xin chào, $name!',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, color: Color(0xFF6D5FFF), size: 32),
        ),
      ],
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary.withOpacity(0.1),
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.show_chart,
                    color: colorScheme.primary, size: 40),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bạn đang làm rất tốt!',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('3 buổi phỏng vấn trong tuần này.'),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () => context.go('/history'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      title,
      style: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Widget _buildStartInterviewCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [colorScheme.primary, colorScheme.secondary],
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.psychology_rounded,
                        color: Colors.white, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Bắt đầu buổi phỏng vấn mới',
                      style: textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Nhập vị trí hoặc lĩnh vực bạn muốn ứng tuyển.'),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'VD: React Developer, Nhân viên Marketing...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () => context.go('/interview'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedTopics() {
    final topics = [
      {'icon': Icons.code, 'label': 'Kỹ thuật'},
      {'icon': Icons.bar_chart, 'label': 'Marketing'},
      {'icon': Icons.account_balance, 'label': 'Ngân hàng'},
      {'icon': Icons.design_services, 'label': 'Design'},
    ];
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: topics.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final topic = topics[index];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              child: SizedBox(
                width: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(topic['icon'] as IconData,
                        size: 36, color: const Color(0xFF6D5FFF)),
                    const SizedBox(height: 8),
                    Text(topic['label'] as String, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
