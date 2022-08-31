part of 'get_transaction_history_bloc.dart';

@immutable
abstract class GetTransactionHistoryEvent {}

class GetTransactionHistoryFromApi extends GetTransactionHistoryEvent {}
