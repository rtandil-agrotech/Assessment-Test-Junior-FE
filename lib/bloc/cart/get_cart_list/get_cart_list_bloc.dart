import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/models/cart_model/cart_list_model.dart';
import 'package:flutter_modul_fe/repositories/cart_repository/cart_repository.dart';
import 'package:meta/meta.dart';

part 'get_cart_list_event.dart';
part 'get_cart_list_state.dart';

class GetCartListBloc extends Bloc<GetCartListEvent, GetCartListState> {
  final CartRepository _repository = CartRepository();
  final UserDataCubit userDataCubit;

  GetCartListBloc({required this.userDataCubit}) : super(GetCartListInitial()) {
    on<GetCartListFromApi>((event, emit) async {
      emit(GetCartListLoading());

      try {
        List<GetCartListDataModel> data = await _repository.getListCartByUserId(
          userId: userDataCubit.state.userData!.id,
        );

        emit(GetCartListDone(data: data));
      } catch (exception) {
        emit(GetCartListFailed(errorMessage: exception.toString()));
      }
    });

    add(GetCartListFromApi());
  }
}
