import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_interview/presentation/chatting/view/models/message.dart';

import 'widgets/animated_background.dart';
import 'widgets/message_bubble.dart';
import 'widgets/typing_indicator.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  bool _isTyping = false;
  int _currentStep = 0;

  late AnimationController _headerAnimationController;
  late AnimationController _inputAnimationController;
  late Animation<double> _headerAnimation;
  late Animation<double> _inputAnimation;

  final List<String> _aiResponses = [
    "Tuyệt vời! Bạn có thể chia sẻ thêm về kinh nghiệm của mình không?",
    "Rất hay! Bạn đã chuẩn bị gì cho cuộc phỏng vấn này chưa?",
    "Perfect! Tôi sẽ tạo những câu hỏi phỏng vấn phù hợp cho bạn. Bạn đã sẵn sàng chưa? ✨",
  ];

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
          children: [
            // Animated background
            const AnimatedBackground(),

            // Main content
            SafeArea(
              child: Column(
                children: [
                  // Header
                  AnimatedBuilder(
                    animation: _headerAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _headerAnimation.value),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.purple.withOpacity(0.3),
                                Colors.blue.withOpacity(0.3),
                              ],
                            ),
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Animated logo
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration: const Duration(seconds: 2),
                                builder: (context, value, child) {
                                  return Transform.rotate(
                                    angle: value * 2 * math.pi,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Colors.purple, Colors.blue],
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(
                                        Icons.auto_awesome,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'AI Interview Coach',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Chuẩn bị phỏng vấn cùng AI',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Messages
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: _messages.length + (_isTyping ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _messages.length && _isTyping) {
                          return const TypingIndicator();
                        }

                        return MessageBubble(
                          message: _messages[index],
                          animationDelay: index * 100,
                        );
                      },
                    ),
                  ),

                  // Input
                  AnimatedBuilder(
                    animation: _inputAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _inputAnimation.value),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            border: Border(
                              top: BorderSide(
                                color: Colors.white.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _messageController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText:
                                          'Nhập vị trí bạn muốn phỏng vấn...',
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                    ),
                                    onSubmitted: (_) => _sendMessage(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: _sendMessage,
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Colors.purple, Colors.blue],
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.purple.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
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
    _headerAnimationController.dispose();
    _inputAnimationController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _addInitialMessage();
  }

  void _addInitialMessage() {
    setState(() {
      _messages.add(Message(
        id: '1',
        text:
            'Chào bạn! Tôi là AI Interview Coach. Hãy cho tôi biết vị trí công việc bạn muốn phỏng vấn nhé! 🚀',
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      ));
    });
  }

  void _initializeAnimations() {
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _inputAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _headerAnimation = Tween<double>(
      begin: -50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.elasticOut,
    ));

    _inputAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _inputAnimationController,
      curve: Curves.elasticOut,
    ));

    _headerAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _inputAnimationController.forward();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: _messageController.text.trim(),
      sender: MessageSender.user,
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

    // Simulate AI response
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _isTyping = false;
      });

      if (_currentStep < _aiResponses.length) {
        final aiMessage = Message(
          id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
          text: _aiResponses[_currentStep],
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        );

        setState(() {
          _messages.add(aiMessage);
          _currentStep++;
        });

        _scrollToBottom();

        // Navigate to success screen after last response
        if (_currentStep >= _aiResponses.length) {
          Timer(const Duration(milliseconds: 1500), () {
            context.goNamed('interview-generated',
                pathParameters: {'position': userMessage.text});
          });
        }
      }
    });
  }
}
