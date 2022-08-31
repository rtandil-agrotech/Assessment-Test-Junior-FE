// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_declarations

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modul_fe/models/failed_response.dart';
import 'package:flutter_modul_fe/models/login_model/login_model.dart';
import 'package:flutter_modul_fe/models/login_model/login_post_model.dart';

class LoginProvider {
  LoginProvider({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: 'http://10.0.2.2:8083/api/v1',
              connectTimeout: 30000,
              receiveTimeout: 3500,
            ));

  final Dio _dio;

  Future userLogin({required LoginPostModel loginData}) async {
    final _url = '/user/login';

    try {
      final Response response = await _dio.post(
        _url,
        data: jsonEncode(loginData),
      );

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      }
      //Else If ini tidak tereksekusi jika email/password salah
      // else if (response.statusCode == 400) {
      //   print("ERROR CODE 400");
      //   return FailedResponse.fromJson(response.data);
      // } else {
      //   return FailedResponse.fromJson(response.data);
      // }
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
