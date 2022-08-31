part of 'delete_from_cart_bloc.dart';

@immutable
abstract class DeleteFromCartState {}

class DeleteFromCartInitial extends DeleteFromCartState {}

class DeleteFromCartLoading extends DeleteFromCartState {}

class DeleteFromCartDone extends DeleteFromCartState {}

class DeleteFromCartFailed extends DeleteFromCartState {
  final String errorMessage;

  DeleteFromCartFailed({required this.errorMessage});
}
