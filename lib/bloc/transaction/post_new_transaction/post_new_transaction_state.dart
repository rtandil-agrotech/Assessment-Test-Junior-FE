part of 'post_new_transaction_bloc.dart';

@immutable
abstract class PostNewTransactionState {}

class PostNewTransactionInitial extends PostNewTransactionState {}

class PostNewTransactionLoading extends PostNewTransactionState {}

class PostNewTransactionDone extends PostNewTransactionState {}

class PostNewTransactionFailed extends PostNewTransactionState {
  final String errorMessage;

  PostNewTransactionFailed({required this.errorMessage});
}
