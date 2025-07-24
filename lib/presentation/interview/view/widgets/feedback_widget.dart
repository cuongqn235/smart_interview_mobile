import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_interview/i18n/strings.g.dart';
import 'package:smart_interview/presentation/interview/bloc/interview_bloc.dart';

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return BlocBuilder<InterviewBloc, InterviewState>(
      builder: (context, state) {
        final questions = state.interviewSession?.questions ?? [];
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              t.interview.feedback,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                color: Colors.white.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${t.interview.question(
                          questionNumber: (index + 1).toString(),
                          totalQuestions: questions.length.toString(),
                        )}: ${question.questionText}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildTitledBox(
                        context,
                        title: t.interview.yourAnswer,
                        content:
                            question.answer?.answerText ?? t.interview.noAnswer,
                        icon: Icons.person_outline,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 12),
                      _buildTitledBox(
                        context,
                        title: t.interview.aiFeedback,
                        content: question.answer?.feedback != null
                            ? '''
${t.interview.structureFeedback}: ${question.answer!.feedback!.structureFeedback}

${t.interview.contentFeedback}: ${question.answer!.feedback!.contentFeedback}

${t.interview.keywordFeedback}: ${question.answer!.feedback!.keywordFeedback}
'''
                            : '...',
                        icon: Icons.psychology_outlined,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTitledBox(
    BuildContext context, {
    required String title,
    required String content,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
