import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
    );
  }

  Widget _buildHeader(BuildContext context, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Xin chào, $name!',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const CircleAvatar(
          // TODO: Replace with user avatar
          child: Icon(Icons.person),
        ),
      ],
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.show_chart,
                color: Theme.of(context).colorScheme.primary, size: 40),
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
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildStartInterviewCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bắt đầu buổi phỏng vấn mới',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text('Nhập vị trí hoặc lĩnh vực bạn muốn ứng tuyển.'),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                  hintText: 'VD: React Developer, Nhân viên Marketing...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () => context.go('/interview'),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestedTopics() {
    // Dummy data
    final topics = [
      {'icon': Icons.code, 'label': 'Kỹ thuật'},
      {'icon': Icons.bar_chart, 'label': 'Marketing'},
      {'icon': Icons.account_balance, 'label': 'Ngân hàng'},
      {'icon': Icons.design_services, 'label': 'Design'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: topics.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final topic = topics[index];
          return Card(
            child: SizedBox(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(topic['icon'] as IconData, size: 32),
                  const SizedBox(height: 8),
                  Text(topic['label'] as String, textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
