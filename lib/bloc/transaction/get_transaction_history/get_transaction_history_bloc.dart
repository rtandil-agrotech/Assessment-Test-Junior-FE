import 'package:bloc/bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/models/transaction_model/transaction_history_model.dart';
import 'package:flutter_modul_fe/repositories/transaction_repository/transaction_repository.dart';
import 'package:meta/meta.dart';

part 'get_transaction_history_event.dart';
part 'get_transaction_history_state.dart';

class GetTransactionHistoryBloc
    extends Bloc<GetTransactionHistoryEvent, GetTransactionHistoryState> {
  final TransactionRepository _repository = TransactionRepository();
  final UserDataCubit userDataCubit;

  GetTransactionHistoryBloc({required this.userDataCubit})
      : super(GetTransactionHistoryInitial()) {
    on<GetTransactionHistoryFromApi>((event, emit) async {
      emit(GetTransactionHistoryLoading());

      try {
        List<GetTransactionHistoryDataModel> data =
            await _repository.getHistoryTransaction(
          userId: userDataCubit.state.userData!.id,
        );

        emit(GetTransactionHistoryDone(data: data));
      } catch (exception) {
        emit(GetTransactionHistoryFailed(errorMessage: exception.toString()));
      }
    });

    add(GetTransactionHistoryFromApi());
  }
}
