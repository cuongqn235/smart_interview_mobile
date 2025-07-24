import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_interview/domain/entities/interview_question_entity.dart';
import 'package:smart_interview/i18n/strings.g.dart';
import 'package:smart_interview/presentation/interview/bloc/interview_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class InterviewQuestionWidget extends StatefulWidget {
  final InterviewQuestionEntity question;
  final int questionNumber;
  final int totalQuestions;
  final String language;
  const InterviewQuestionWidget({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
    required this.language,
  });

  @override
  State<InterviewQuestionWidget> createState() =>
      _InterviewQuestionWidgetState();
}

class _InterviewQuestionWidgetState extends State<InterviewQuestionWidget>
    with TickerProviderStateMixin {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  late String _text;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _listeningAnimationController;
  late Animation<double> _listeningAnimation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        t.interview.question(
                          questionNumber: widget.questionNumber.toString(),
                          totalQuestions: widget.totalQuestions.toString(),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      widget.question.questionText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black26,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(minHeight: 150),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Text(
                        _text,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white.withOpacity(0.8),
                          fontStyle: _text == t.interview.yourAnswer
                              ? FontStyle.italic
                              : FontStyle.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildMicButton(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _listeningAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _text = t.interview.yourAnswer;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.forward();

    _listeningAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _listeningAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _listeningAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Widget _buildMicButton() {
    return GestureDetector(
      onTap: _listen,
      child: AnimatedBuilder(
        animation: _listeningAnimationController,
        builder: (context, child) {
          final scale = _isListening ? _listeningAnimation.value : 1.0;
          return Transform.scale(
            scale: scale,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: _isListening ? 5 * scale : 0,
                  )
                ],
              ),
              child: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                color: Colors.white,
                size: 40,
              ),
            ),
          );
        },
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      final available = await _speech.initialize(
        onStatus: (val) {
          if (kDebugMode) {
            print('onStatus: $val');
          }
        },
        onError: (val) {
          if (kDebugMode) {
            print('onError: $val');
          }
        },
      );
      if (available) {
        setState(() => _isListening = true);
        _listeningAnimationController.repeat(reverse: true);
        _speech.listen(
          localeId: LocaleSettings.currentLocale.languageCode,
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            context.read<InterviewBloc>().add(
                  InterviewEvent.answerChanged(
                    questionId: widget.question.id,
                    answer: _text,
                  ),
                );
            // if (val.hasConfidenceRating && val.confidence > 0) {
            //   _confidence = val.confidence;
            // }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _listeningAnimationController.stop();
      _listeningAnimationController.value =
          _listeningAnimationController.lowerBound;
      _speech.stop();
    }
  }
}
