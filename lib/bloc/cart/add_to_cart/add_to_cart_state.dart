part of 'add_to_cart_bloc.dart';

@immutable
abstract class AddToCartState {}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {
  final int bookId;

  AddToCartLoading({required this.bookId});
}

class AddToCartDone extends AddToCartState {}

class AddToCartFailed extends AddToCartState {
  final String errorMessage;

  AddToCartFailed({required this.errorMessage});
}
