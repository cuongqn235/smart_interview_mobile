import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_interview/core/components/dimens_widget.dart';
import 'package:smart_interview/i18n/strings.g.dart';
import 'package:smart_interview/presentation/interview/bloc/interview_bloc.dart';

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return SafeArea(
      top: false,
      child: BlocBuilder<InterviewBloc, InterviewState>(
        builder: (context, state) {
          final questions = state.interviewSession?.questions ?? [];
          return Container(
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
              bottom: false,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
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
                                dimen16,
                                _buildTitledBox(
                                  context,
                                  title: question.answer?.answerText ??
                                      t.interview.noAnswer,
                                  content: '',
                                  icon: Icons.person_outline,
                                  color: Colors.blue,
                                ),
                                dimen12,
                                _buildTitledBox(
                                  context,
                                  title: t.interview.aiFeedback,
                                  icon: Icons.psychology_outlined,
                                  color: Colors.purple,
                                  contentWidget: question.answer?.feedback !=
                                          null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildFeedbackDetailRow(
                                              title:
                                                  '${t.interview.structureFeedback}:',
                                              content: question.answer!
                                                  .feedback!.structureFeedback,
                                              color: Colors.amber.shade300,
                                            ),
                                            const SizedBox(height: 10),
                                            _buildFeedbackDetailRow(
                                              title:
                                                  '${t.interview.contentFeedback}:',
                                              content: question.answer!
                                                  .feedback!.contentFeedback,
                                              color: Colors.green.shade300,
                                            ),
                                            const SizedBox(height: 10),
                                            _buildFeedbackDetailRow(
                                              title:
                                                  '${t.interview.keywordFeedback}:',
                                              content: question.answer!
                                                  .feedback!.keywordFeedback,
                                              color: Colors.blue.shade300,
                                            ),
                                          ],
                                        )
                                      : Text(
                                          '...',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  _buildNavButton(
                    onPressed: () {
                      context.pop();
                    },
                    text: t.interview.finish,
                    icon: Icons.check,
                    isPrimary: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedbackDetailRow({
    required String title,
    required String content,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildNavButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    bool isPrimary = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
              mainAxisAlignment: MainAxisAlignment.center,
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

  Widget _buildTitledBox(
    BuildContext context, {
    required String title,
    String? content,
    Widget? contentWidget,
    required IconData icon,
    required Color color,
  }) {
    assert(
      content != null || contentWidget != null,
      'Either content or contentWidget must be provided.',
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title.isEmpty ? 'Chưa có câu trả lời' : title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: contentWidget ??
                Visibility(
                  visible: (content ?? '').isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      content!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
