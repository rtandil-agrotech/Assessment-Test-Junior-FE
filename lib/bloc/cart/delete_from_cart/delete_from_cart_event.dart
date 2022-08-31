part of 'delete_from_cart_bloc.dart';

@immutable
abstract class DeleteFromCartEvent {}

class DeleteBookFromCart extends DeleteFromCartEvent {
  final int bookId;

  DeleteBookFromCart({required this.bookId});
}
