import 'package:bloc/bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/repositories/cart_repository/cart_repository.dart';
import 'package:meta/meta.dart';

part 'delete_from_cart_event.dart';
part 'delete_from_cart_state.dart';

class DeleteFromCartBloc
    extends Bloc<DeleteFromCartEvent, DeleteFromCartState> {
  final CartRepository _repository = CartRepository();
  final UserDataCubit userDataCubit;

  DeleteFromCartBloc({required this.userDataCubit})
      : super(DeleteFromCartInitial()) {
    on<DeleteBookFromCart>((event, emit) async {
      emit(DeleteFromCartLoading());

      try {
        await _repository.removeDataFromCart(
          userId: userDataCubit.state.userData!.id,
          bookId: event.bookId,
        );

        emit(DeleteFromCartDone());
      } catch (exception) {
        emit(DeleteFromCartFailed(errorMessage: exception.toString()));
      }
    });
  }
}
