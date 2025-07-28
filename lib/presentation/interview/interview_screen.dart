import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:smart_interview/core/di/injectable.dart';
import 'package:smart_interview/core/models/status.dart';
import 'package:smart_interview/presentation/interview/bloc/interview_bloc.dart';

import 'view/widgets/feedback_widget.dart';
import 'view/widgets/generated_interview_widget.dart';
import 'view/widgets/generating_interview_widget.dart';
import 'view/widgets/interview_session_widget.dart';

class InterviewScreen extends StatefulWidget {
  final String position;
  final String? language;
  const InterviewScreen({super.key, required this.position, this.language});

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  late final InterviewBloc _interviewBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _interviewBloc,
        child: BlocListener<InterviewBloc, InterviewState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status is Loading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
          },
          child: BlocBuilder<InterviewBloc, InterviewState>(
            builder: (context, state) {
              return switch (state.interviewStatus) {
                InterviewStatus.generating => GeneratingInterviewWidget(
                    position: widget.position,
                  ),
                InterviewStatus.generated => GeneratedInterviewWidget(
                    position: widget.position,
                  ),
                InterviewStatus.interview => const InterviewSessionWidget(),
                InterviewStatus.feedback => const FeedbackWidget(),
              };
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _interviewBloc = getIt<InterviewBloc>();
    _interviewBloc.add(InterviewEvent.started(
      position: widget.position,
      language: widget.language,
    ));
  }
}
