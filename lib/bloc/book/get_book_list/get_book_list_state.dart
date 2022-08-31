part of 'get_book_list_bloc.dart';

@immutable
abstract class GetBookListState {}

class GetBookListInitial extends GetBookListState {}

class GetBookListLoading extends GetBookListState {}

class GetBookListDone extends GetBookListState {
  final List<GetBookListDataPerPageModel> data;
  final List<GetCartListDataModel> cartData;

  GetBookListDone({
    required this.data,
    required this.cartData,
  });
}

class GetBookListFailed extends GetBookListState {
  final String errorMessage;

  GetBookListFailed({required this.errorMessage});
}

class GetBookListBySearchDone extends GetBookListState {
  final List<GetBookBySearchData> data;
  final List<GetCartListDataModel> cartData;

  GetBookListBySearchDone({
    required this.data,
    required this.cartData,
  });
}

class GetBookListBySearchFailed extends GetBookListState {
  final String errorMessage;

  GetBookListBySearchFailed({required this.errorMessage});
}
