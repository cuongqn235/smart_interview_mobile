import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_interview/core/di/injectable.dart';
import 'package:smart_interview/presentation/interview/bloc/interview_bloc.dart';

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
    return BlocProvider(
      create: (context) => _interviewBloc,
      child: const Placeholder(),
    );
  }

  @override
  void initState() {
    super.initState();
    _interviewBloc = getIt<InterviewBloc>();
  }
}
