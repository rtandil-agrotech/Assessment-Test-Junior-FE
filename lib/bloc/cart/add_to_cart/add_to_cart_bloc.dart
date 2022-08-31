import 'package:bloc/bloc.dart';
import 'package:flutter_modul_fe/models/cart_model/add_to_cart_model.dart';
import 'package:flutter_modul_fe/repositories/cart_repository/cart_repository.dart';
import 'package:meta/meta.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final CartRepository _repository = CartRepository();

  AddToCartBloc() : super(AddToCartInitial()) {
    on<AddBookToCart>((event, emit) async {
      emit(AddToCartLoading(bookId: event.data.bookId));

      try {
        await _repository.addDataToCart(data: event.data);

        emit(AddToCartDone());
      } catch (exception) {
        emit(AddToCartFailed(errorMessage: exception.toString()));
      }
    });
  }
}
