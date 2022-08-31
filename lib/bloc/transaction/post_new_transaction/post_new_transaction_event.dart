part of 'post_new_transaction_bloc.dart';

@immutable
abstract class PostNewTransactionEvent {}

class CreateNewTransaction extends PostNewTransactionEvent {
  final AddNewTransactionModel data;

  CreateNewTransaction({required this.data});
}
