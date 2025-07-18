import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:smart_interview/domain/entities/message_entity.dart';
import 'package:smart_interview/presentation/chatting/view/widgets/typing_indicator.dart';

import 'widgets/animated_background.dart';
import 'widgets/message_bubble.dart';
import 'widgets/particle_system.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({Key? key}) : super(key: key);

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<MessageEntity> _messages = [];

  bool _isTyping = false;
  bool _isRecording = false;
  int _clarificationStep = 0;

  late AnimationController _pulseController;
  late AnimationController _recordingController;
  late AnimationController _backgroundController;

  final List<String> _clarificationQuestions = [
    "What specific role are you applying for? (e.g., Senior Frontend Developer, Product Manager)",
    "What's your experience level? (Entry-level, Mid-level, Senior, Lead)",
    "Which company or industry are you targeting?",
    "What key skills or technologies should we focus on?",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F172A), // slate-900
              Color(0xFF581C87), // purple-900
              Color(0xFF0F172A), // slate-900
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated Background
            AnimatedBackground(controller: _backgroundController),

            // Particle System
            const ParticleSystem(),

            // Main Content
            SafeArea(
              child: Column(
                children: [
                  // Header
                  _buildHeader(),

                  // Chat Messages
                  Expanded(
                    child: _buildMessagesList(),
                  ),

                  // Input Area
                  _buildInputArea(),
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
    _pulseController.dispose();
    _recordingController.dispose();
    _backgroundController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    setState(() {
      _messages.add(MessageEntity(
        id: 'welcome',
        content:
            "Hi! I'm your AI Interview Coach. I'll help you prepare for your upcoming interview.\n\nTo get started, could you tell me about the position you're applying for?",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 80,
        borderRadius: 20,
        blur: 20,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.1),
            Colors.purple.withOpacity(0.1),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.3),
            Colors.purple.withOpacity(0.3),
          ],
        ),
        child: Row(
          children: [
            // AI Avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 24,
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .rotate(duration: 3.seconds),

            const SizedBox(width: 16),

            // Title and Status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'AI Interview Coach',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      )
                          .animate(onPlay: (controller) => controller.repeat())
                          .scale(
                              duration: 2.seconds,
                              begin: const Offset(1, 1),
                              end: const Offset(1.2, 1.2)),
                      const SizedBox(width: 8),
                      const Text(
                        'Active Session',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3);
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 80,
        borderRadius: 25,
        blur: 20,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.1),
            Colors.purple.withOpacity(0.1),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.purple.withOpacity(0.3),
            Colors.blue.withOpacity(0.3),
          ],
        ),
        child: Row(
          children: [
            // Text Input
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Share your thoughts...',
                    hintStyle: TextStyle(color: Colors.white60),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),

            // Voice Recording Button
            GestureDetector(
              onTap: _toggleRecording,
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isRecording ? Colors.red : Colors.purple,
                  boxShadow: [
                    BoxShadow(
                      color: (_isRecording ? Colors.red : Colors.purple)
                          .withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 20,
                ),
              )
                  .animate(
                    target: _isRecording ? 1 : 0,
                  )
                  .scale(
                    duration: 200.ms,
                    begin: const Offset(1, 1),
                    end: const Offset(1.1, 1.1),
                  ),
            ),

            // Send Button
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            )
                .animate()
                .scale(
                  duration: 200.ms,
                  curve: Curves.easeInOut,
                )
                .then()
                .shimmer(
                  duration: 2.seconds,
                  color: Colors.white.withOpacity(0.3),
                ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _messages.length + (_isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length && _isTyping) {
          return const TypingIndicator()
              .animate()
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.3);
        }

        final message = _messages[index];
        return MessageBubble(
          message: message,
          index: index,
        ).animate(delay: (index * 100).ms).fadeIn(duration: 500.ms).slideX(
              begin: message.isUser ? 0.3 : -0.3,
              duration: 400.ms,
              curve: Curves.easeOutBack,
            );
      },
    );
  }

  String _generateAIResponse(String userInput) {
    final lowerInput = userInput.toLowerCase();

    if (_clarificationStep == 0) {
      if (lowerInput.contains('frontend') ||
          lowerInput.contains('react') ||
          lowerInput.contains('javascript')) {
        _clarificationStep = 1;
        return "Great! I see you're preparing for a Frontend Developer role. ${_clarificationQuestions[1]}";
      } else if (lowerInput.contains('backend') ||
          lowerInput.contains('api') ||
          lowerInput.contains('server')) {
        _clarificationStep = 1;
        return "Excellent! Backend development is a great field. ${_clarificationQuestions[1]}";
      } else {
        return "I'd like to learn more about the specific role. ${_clarificationQuestions[0]}";
      }
    }

    if (_clarificationStep < _clarificationQuestions.length - 1) {
      _clarificationStep++;
      return "Thanks for that information! ${_clarificationQuestions[_clarificationStep]}";
    }

    if (_clarificationStep == _clarificationQuestions.length - 1) {
      // Navigate to questions screen after delay
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushNamed(context, '/questions');
      });

      return "Perfect! I have all the information I need. Based on your profile, I've prepared a customized set of interview questions. Let me show you what we'll be working on...";
    }

    return "Thank you for the information. Let me prepare your interview questions...";
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _recordingController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = MessageEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: _messageController.text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Haptic feedback
    HapticFeedback.lightImpact();

    // Simulate AI response delay
    await Future.delayed(
        Duration(milliseconds: 1500 + (DateTime.now().millisecond % 1000)));

    final aiResponse = _generateAIResponse(userMessage.content);

    setState(() {
      _messages.add(MessageEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: aiResponse,
        isUser: false,
        timestamp: DateTime.now(),
      ));
      _isTyping = false;
    });

    _scrollToBottom();
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });

    if (_isRecording) {
      _recordingController.repeat();
      HapticFeedback.mediumImpact();
    } else {
      _recordingController.stop();
    }
  }
}
