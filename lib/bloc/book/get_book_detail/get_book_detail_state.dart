part of 'get_book_detail_bloc.dart';

@immutable
abstract class GetBookDetailState {}

class GetBookDetailInitial extends GetBookDetailState {}

class GetBookDetailLoading extends GetBookDetailState {}

class GetBookDetailDone extends GetBookDetailState {
  final List<GetBookByIdData> data;
  final List<GetCartListDataModel> cartData;

  GetBookDetailDone({required this.data, required this.cartData});
}

class GetBookDetailFailed extends GetBookDetailState {
  final String errorMessage;

  GetBookDetailFailed({required this.errorMessage});
}
