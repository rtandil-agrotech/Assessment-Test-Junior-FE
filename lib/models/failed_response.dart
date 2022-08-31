class FailedResponse {
  final int code;
  final String message;

  FailedResponse({
    required this.code,
    required this.message,
  });

  factory FailedResponse.fromJson(Map<String, dynamic> json) {
    return FailedResponse(
      code: json['code'],
      message: json['message'],
    );
  }
}
