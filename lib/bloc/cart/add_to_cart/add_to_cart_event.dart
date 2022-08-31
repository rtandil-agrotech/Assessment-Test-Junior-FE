part of 'add_to_cart_bloc.dart';

@immutable
abstract class AddToCartEvent {}

class AddBookToCart extends AddToCartEvent {
  final AddBookToCartModel data;

  AddBookToCart({required this.data});
}
