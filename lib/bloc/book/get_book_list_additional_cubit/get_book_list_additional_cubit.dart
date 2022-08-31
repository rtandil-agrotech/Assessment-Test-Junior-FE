import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'get_book_list_additional_state.dart';

class GetBookListAdditionalCubit extends Cubit<GetBookListAdditionalState> {
  GetBookListAdditionalCubit() : super(GetBookListAdditionalInitial());

  void changeState(GetBookListAdditionalState state) {
    emit(state);
  }
}
