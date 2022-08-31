import 'package:bloc/bloc.dart';
import 'package:flutter_modul_fe/models/transaction_model/add_new_transaction_model.dart';
import 'package:flutter_modul_fe/repositories/transaction_repository/transaction_repository.dart';
import 'package:meta/meta.dart';

part 'post_new_transaction_event.dart';
part 'post_new_transaction_state.dart';

class PostNewTransactionBloc
    extends Bloc<PostNewTransactionEvent, PostNewTransactionState> {
  final TransactionRepository _repository = TransactionRepository();

  PostNewTransactionBloc() : super(PostNewTransactionInitial()) {
    on<CreateNewTransaction>((event, emit) async {
      emit(PostNewTransactionLoading());

      try {
        await _repository.createNewTransaction(data: event.data);

        emit(PostNewTransactionDone());
      } catch (exception) {
        emit(PostNewTransactionFailed(errorMessage: exception.toString()));
      }
    });
  }
}
