// ignore_for_file: unnecessary_this

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modul_fe/models/book_model/book_list_model.dart';
import 'package:flutter_modul_fe/models/book_model/search_type_enum.dart';
import 'package:flutter_modul_fe/models/cart_model/cart_list_model.dart';
import 'package:meta/meta.dart';

part 'get_book_list_settings_state.dart';

class GetBookListSettingsCubit extends Cubit<GetBookListSettingsState> {
  GetBookListSettingsCubit() : super(GetBookListSettingsInitial());

  int pageNumber = 1;
  int totalData = 0;
  int totalPage = 1;
  double limit = 20;
  List<GetBookListDataPerPageModel> data = [];
  SearchByType searchParam = SearchByType(
    searchType: SearchType.title,
    param: "",
  );
  List<GetCartListDataModel> cartData = [];

  void goToPage(int newPage) {
    this.pageNumber = newPage;
  }

  void getBookListData(List<GetBookListDataPerPageModel> bookData) {
    data.addAll(bookData);
  }

  void getBookListPaginationData(GetBookListDataModel data) {
    if (data.totalPage > 0) {
      this.totalPage = data.totalPage;
    } else {
      this.totalPage = 1;
    }

    if (data.currentPage > 0) {
      this.pageNumber = data.currentPage;
    } else {
      this.pageNumber = 1;
    }

    this.totalData = data.totalData;
  }

  void searchByParam(SearchByType param) {
    emit(GetBookListSettingsLoading());
    this.searchParam = param;
    emit(GetBookListSettingsDone());
  }

  void updateCartData(List<GetCartListDataModel> newCartData) {
    this.cartData.addAll(newCartData);
  }
}
