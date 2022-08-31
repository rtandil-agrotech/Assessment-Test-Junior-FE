// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_declarations

import 'package:dio/dio.dart';
import 'package:flutter_modul_fe/models/book_model/book_by_search_model.dart';
import 'package:flutter_modul_fe/models/book_model/book_detail_model.dart';
import 'package:flutter_modul_fe/models/book_model/book_list_model.dart';
import 'package:flutter_modul_fe/models/book_model/search_type_enum.dart';
import 'package:flutter_modul_fe/models/failed_response.dart';

class BookProvider {
  BookProvider({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: 'http://10.0.2.2:8083/api/v1',
              connectTimeout: 30000,
              receiveTimeout: 15000,
            ));

  final Dio _dio;

  Future getBookList({required int page, required double limit}) async {
    final _url = '/book';

    Map<String, dynamic> queryParam = {
      'page': page,
      'limit': limit.floor(),
    };

    try {
      final Response response = await _dio.get(
        _url,
        queryParameters: queryParam,
      );

      if (response.statusCode == 200) {
        return GetBookListModelPack.fromJson(response.data);
      }
      // else {
      //   return FailedResponse.fromJson(response.data);
      // }
    } catch (exception) {
      throw Exception(exception);
    }
  }

  Future getBookBySearch({required SearchByType param}) async {
    final _url = '/book/search';

    Map<String, dynamic> queryParam = {};

    if (param.searchType == SearchType.title) {
      queryParam['title'] = param.param;
    } else if (param.searchType == SearchType.author) {
      queryParam['author'] = param.param;
    } else if (param.searchType == SearchType.isbn) {
      queryParam['isbn'] = param.param;
    }

    try {
      final Response response = await _dio.get(
        _url,
        queryParameters: queryParam,
      );

      if (response.statusCode == 200) {
        return GetBookBySearchModelPack.fromJson(response.data);
      }
      // else {
      //   return FailedResponse.fromJson(response.data);
      // }
    } catch (exception) {
      throw Exception(exception);
    }
  }

  Future getBookById({required int id}) async {
    final _url = '/book/$id';

    try {
      final Response response = await _dio.get(
        _url,
      );

      if (response.statusCode == 200) {
        return GetBookByIdModelPack.fromJson(response.data);
      }
      // else {
      //   return FailedResponse.fromJson(response.data);
      // }
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
