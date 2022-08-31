// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_declarations

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modul_fe/models/transaction_model/add_new_transaction_model.dart';
import 'package:flutter_modul_fe/models/transaction_model/transaction_history_model.dart';

class TransactionProvider {
  TransactionProvider({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: 'http://10.0.2.2:8083/api/v1',
              connectTimeout: 30000,
              receiveTimeout: 3500,
            ));

  final Dio _dio;

  Future getHistoryTransaction({required int userId}) async {
    final _url = '/transaction';

    Map<String, dynamic> queryParam = {
      'user_id': userId,
    };

    try {
      final Response response = await _dio.get(
        _url,
        queryParameters: queryParam,
      );

      if (response.statusCode == 200) {
        return GetTransactionHistoryModelPack.fromJson(response.data);
      }
    } catch (exception) {
      throw Exception(exception);
    }
  }

  Future createNewTransaction({
    required AddNewTransactionModel data,
  }) async {
    final _url = '/transaction';

    try {
      final Response response = await _dio.post(
        _url,
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        if (response.data['message'] == "Data transaction Created") {
          return response.data['message'];
        } else {
          return response.data['message'];
        }
      }
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
