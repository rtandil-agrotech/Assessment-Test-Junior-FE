part of 'get_cart_list_bloc.dart';

@immutable
abstract class GetCartListState {}

class GetCartListInitial extends GetCartListState {}

class GetCartListLoading extends GetCartListState {}

class GetCartListDone extends GetCartListState {
  final List<GetCartListDataModel> data;

  GetCartListDone({required this.data});
}

class GetCartListFailed extends GetCartListState {
  final String errorMessage;

  GetCartListFailed({required this.errorMessage});
}
