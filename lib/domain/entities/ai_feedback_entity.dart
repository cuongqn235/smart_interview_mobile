class AiFeedbackEntity {
  final int id;
  final String structureFeedback;
  final String contentFeedback;
  final String keywordFeedback;
  final int overallScore;
  AiFeedbackEntity({
    required this.id,
    required this.structureFeedback,
    required this.contentFeedback,
    required this.keywordFeedback,
    required this.overallScore,
  });
}
