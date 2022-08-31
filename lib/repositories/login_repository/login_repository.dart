import 'package:flutter_modul_fe/models/failed_response.dart';
import 'package:flutter_modul_fe/models/login_model/login_model.dart';
import 'package:flutter_modul_fe/models/login_model/login_post_model.dart';
import 'package:flutter_modul_fe/providers/login_provider/login_provider.dart';
import 'package:flutter_modul_fe/repositories/login_repository/login_exceptions.dart';

class LoginRepository {
  LoginRepository({LoginProvider? bookProvider})
      : _apiProvider = bookProvider ?? LoginProvider();

  final LoginProvider _apiProvider;

  Future userLogin({required LoginPostModel loginData}) async {
    final response = await _apiProvider.userLogin(loginData: loginData);

    if (response is LoginModel) {
      return response.data;
    } else if (response is FailedResponse) {
      switch (response.message) {
        case "Wrong password":
          throw WrongPasswordLoginFailed();
        case "Wrong email":
          throw WrongEmailLoginFailed();
        default:
          throw LoginFailed();
      }
    }
    throw LoginFailed();
  }
}
