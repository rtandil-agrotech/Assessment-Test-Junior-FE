import 'package:bloc/bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/models/book_model/book_detail_model.dart';
import 'package:flutter_modul_fe/models/cart_model/cart_list_model.dart';
import 'package:flutter_modul_fe/repositories/book_repository/book_repository.dart';
import 'package:flutter_modul_fe/repositories/cart_repository/cart_repository.dart';
import 'package:meta/meta.dart';

part 'get_book_detail_event.dart';
part 'get_book_detail_state.dart';

class GetBookDetailBloc extends Bloc<GetBookDetailEvent, GetBookDetailState> {
  final BookRepository _repository = BookRepository();
  final CartRepository _cartRepository = CartRepository();
  final UserDataCubit userDataCubit;

  GetBookDetailBloc({required this.userDataCubit})
      : super(GetBookDetailInitial()) {
    on<GetBookDetailFromApi>((event, emit) async {
      emit(GetBookDetailLoading());

      try {
        List<GetBookByIdData> data =
            await _repository.getBookById(id: event.id);

        List<GetCartListDataModel> cartData =
            await _cartRepository.getListCartByUserId(
          userId: userDataCubit.state.userData!.id,
        );

        emit(GetBookDetailDone(data: data, cartData: cartData));
      } catch (exception) {
        emit(GetBookDetailFailed(errorMessage: exception.toString()));
      }
    });
  }
}
