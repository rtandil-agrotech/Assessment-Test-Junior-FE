// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_declarations

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modul_fe/models/cart_model/add_to_cart_model.dart';
import 'package:flutter_modul_fe/models/cart_model/cart_list_model.dart';

class CartProvider {
  CartProvider({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: 'http://10.0.2.2:8083/api/v1',
              connectTimeout: 30000,
              receiveTimeout: 3500,
            ));

  final Dio _dio;

  Future getListCartByUserId({required int userId}) async {
    final _url = '/cart';

    Map<String, dynamic> queryParam = {
      'user_id': userId,
    };

    try {
      final Response response = await _dio.get(
        _url,
        queryParameters: queryParam,
      );

      if (response.statusCode == 200) {
        return GetCartListModelPack.fromJson(response.data);
      }
    } catch (exception) {
      throw Exception(exception);
    }
  }

  Future addDataToCart({
    required AddBookToCartModel data,
  }) async {
    final _url = '/cart';

    try {
      final Response response = await _dio.post(
        _url,
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        if (response.data['message'] == "Data cart Created") {
          return response.data['message'];
        } else {
          return response.data['message'];
        }
      }
    } catch (exception) {
      throw Exception(exception);
    }
  }

  Future removeDataFromCart({
    required int userId,
    required int bookId,
  }) async {
    final _url = '/cart';

    Map<String, dynamic> queryParam = {
      'user_id': userId,
      'book_id': bookId,
    };

    try {
      final Response response = await _dio.delete(
        _url,
        queryParameters: queryParam,
      );

      if (response.statusCode == 200) {
        if (response.data['message'] == "Data cart Deleted") {
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
