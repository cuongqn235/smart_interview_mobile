import 'package:smart_interview/core/ultis/freezed_ultis.dart';

part 'interview_session_creation_request.g.dart';

@request
class InterviewSessionCreationRequest {
  final String positionDescription;
  final String? language;
  InterviewSessionCreationRequest({
    required this.positionDescription,
    this.language,
  });
  Map<String, dynamic> toJson() =>
      _$InterviewSessionCreationRequestToJson(this);
}
