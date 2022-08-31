class LoginModel {
  final bool status;
  final int code;
  final String message;
  final LoginData data;

  LoginModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: LoginData.fromJson(json['data']),
    );
  }
}

class LoginData {
  final int id;
  final String userName;

  LoginData({
    required this.id,
    required this.userName,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['user_id'],
      userName: json['username'],
    );
  }
}
