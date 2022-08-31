part of 'get_transaction_history_bloc.dart';

@immutable
abstract class GetTransactionHistoryState {}

class GetTransactionHistoryInitial extends GetTransactionHistoryState {}

class GetTransactionHistoryLoading extends GetTransactionHistoryState {}

class GetTransactionHistoryDone extends GetTransactionHistoryState {
  final List<GetTransactionHistoryDataModel> data;

  GetTransactionHistoryDone({required this.data});
}

class GetTransactionHistoryFailed extends GetTransactionHistoryState {
  final String errorMessage;

  GetTransactionHistoryFailed({required this.errorMessage});
}
