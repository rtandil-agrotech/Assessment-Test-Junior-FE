import 'package:flutter_modul_fe/models/book_model/book_by_search_model.dart';
import 'package:flutter_modul_fe/models/book_model/book_detail_model.dart';
import 'package:flutter_modul_fe/models/book_model/book_list_model.dart';
import 'package:flutter_modul_fe/models/book_model/search_type_enum.dart';
import 'package:flutter_modul_fe/providers/book_provider/book_provider.dart';

class BookRepository {
  BookRepository({BookProvider? bookProvider})
      : _apiProvider = bookProvider ?? BookProvider();

  final BookProvider _apiProvider;

  Future getBookList({
    required int page,
    required double limit,
  }) async {
    final response = await _apiProvider.getBookList(page: page, limit: limit);

    if (response is GetBookListModelPack) {
      return response;
    } else {
      return response;
    }
  }

  Future getBookBySearch({required SearchByType param}) async {
    final response = await _apiProvider.getBookBySearch(param: param);

    if (response is GetBookBySearchModelPack) {
      return response.data;
    } else {
      return response;
    }
  }

  Future getBookById({required int id}) async {
    final response = await _apiProvider.getBookById(id: id);

    if (response is GetBookByIdModelPack) {
      return response.data;
    } else {
      return response;
    }
  }
}
