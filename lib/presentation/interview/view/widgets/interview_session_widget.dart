import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smart_interview/core/components/dimens_widget.dart';
import 'package:smart_interview/i18n/strings.g.dart';
import 'package:smart_interview/presentation/interview/bloc/interview_bloc.dart';
import 'package:smart_interview/presentation/interview/view/widgets/interview_question_widget.dart';

class InterviewSessionWidget extends StatefulWidget {
  const InterviewSessionWidget({super.key});

  @override
  State<InterviewSessionWidget> createState() => _InterviewSessionWidgetState();
}

class _InterviewSessionWidgetState extends State<InterviewSessionWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterviewBloc, InterviewState>(
      builder: (context, state) {
        final questions = state.interviewSession?.questions ?? [];
        final language = state.language;
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
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: questions.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return InterviewQuestionWidget(
                          question: questions[index],
                          questionNumber: index + 1,
                          totalQuestions: questions.length,
                          language: language,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: _buildNavigationButtons(context, questions.length),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    bool isPrimary = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: isPrimary
            ? const LinearGradient(colors: [Colors.purple, Colors.blue])
            : null,
        color: isPrimary ? null : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(28),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                if (isPrimary) ...[
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  dimen8,
                ],
                Icon(icon, color: Colors.white, size: 20),
                if (!isPrimary) ...[
                  dimen8,
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context, int totalQuestions) {
    final t = Translations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentIndex > 0)
          _buildNavButton(
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            text: t.interview.previous,
            icon: Icons.arrow_back,
          )
        else
          const Gap(120), // Placeholder for alignment
        _buildNavButton(
          onPressed: () {
            if (_currentIndex < totalQuestions - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            } else {
              context
                  .read<InterviewBloc>()
                  .add(const InterviewEvent.feedbackRequested());
            }
          },
          text: _currentIndex == totalQuestions - 1
              ? t.interview.finish
              : t.interview.next,
          icon: _currentIndex == totalQuestions - 1
              ? Icons.check_circle_outline
              : Icons.arrow_forward,
          isPrimary: true,
        ),
      ],
    );
  }
}
