import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_interview/core/di/injectable.dart';
import 'package:smart_interview/core/theme/colors.dart';
import 'package:smart_interview/core/theme/styles.dart';
import 'package:smart_interview/domain/entities/message_entity.dart';
import 'package:smart_interview/i18n/strings.g.dart';
import 'package:smart_interview/presentation/chatting/bloc/chatting_bloc.dart';

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
  late ChattingBloc _chattingBloc;

  late AnimationController _headerAnimationController;
  late AnimationController _inputAnimationController;
  late Animation<double> _headerAnimation;
  late Animation<double> _inputAnimation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _chattingBloc,
      child: BlocListener<ChattingBloc, ChattingState>(
        listenWhen: (previous, current) =>
            previous.messages.length != current.messages.length,
        listener: (context, state) {
          if (state.messages.last is MessageEntityEnd) {
            FocusScope.of(context).unfocus();
            _scrollToBottom();
          }
        },
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
            child: Stack(
              children: [
                // Animated background
                const AnimatedBackground(),

                // Main content
                SafeArea(
                  bottom: false,
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
                                    AppColors.purple.withOpacity(0.3),
                                    AppColors.blue.withOpacity(0.3),
                                  ],
                                ),
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.white10,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Animated logo
                                  // TweenAnimationBuilder<double>(
                                  //   tween: Tween(begin: 0.0, end: 1.0),
                                  //   duration: const Duration(seconds: 2),
                                  //   builder: (context, value, child) {
                                  //     return Transform.rotate(
                                  //       angle: value * 2 * math.pi,
                                  //       child: Container(
                                  //         width: 40,
                                  //         height: 40,
                                  //         decoration: BoxDecoration(
                                  //           gradient: AppColors.primaryGradient,
                                  //           borderRadius:
                                  //               BorderRadius.circular(20),
                                  //         ),
                                  //         child: const Icon(
                                  //           Icons.auto_awesome,
                                  //           color: Colors.white,
                                  //           size: 20,
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  InkWell(
                                    onTap: () => context.pop(),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: AppColors.primaryGradient,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'AI Interview Coach',
                                          style: AppStyles.withColor(
                                              AppStyles.withWeight(
                                                  AppStyles.titleMedium,
                                                  FontWeight.bold),
                                              Colors.white),
                                        ),
                                        Text(
                                          'Chuẩn bị phỏng vấn cùng AI',
                                          style: AppStyles.withColor(
                                              AppStyles.bodySmall,
                                              Colors.white70),
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
                        child: BlocBuilder<ChattingBloc, ChattingState>(
                          builder: (context, state) {
                            return ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(16),
                              itemCount: state.messages.length +
                                  (state.isTyping ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index == state.messages.length &&
                                    state.isTyping) {
                                  return const TypingIndicator();
                                }
                                return MessageBubble(
                                  message: state.messages[index],
                                  animationDelay: index * 100,
                                );
                              },
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
                                color: AppColors.black20,
                                border: Border(
                                  top: BorderSide(
                                    color: AppColors.white10,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom +
                                              8),
                                      decoration: BoxDecoration(
                                        color: AppColors.white10,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                          color: AppColors.white20,
                                        ),
                                      ),
                                      child: TextField(
                                        controller: _messageController,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          hintText:
                                              'Nhập vị trí bạn muốn phỏng vấn...',
                                          hintStyle: AppStyles.withColor(
                                              AppStyles.bodyMedium,
                                              AppColors.white50),
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
                                        gradient: AppColors.primaryGradient,
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.purple
                                                .withOpacity(0.3),
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
    _chattingBloc =
        getIt<ChattingBloc>(param1: LocaleSettings.currentLocale.languageCode)
          ..add(ChattingEvent.onStart());
    _initializeAnimations();
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

    _chattingBloc
        .add(ChattingEvent.sendMessage(_messageController.text.trim()));

    _messageController.clear();
    _scrollToBottom();

    // Haptic feedback
    HapticFeedback.lightImpact();
  }
}
