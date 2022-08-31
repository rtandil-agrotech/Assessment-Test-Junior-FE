import 'package:flutter_modul_fe/models/transaction_model/add_new_transaction_model.dart';
import 'package:flutter_modul_fe/models/transaction_model/transaction_history_model.dart';
import 'package:flutter_modul_fe/providers/transaction_provider/transaction_provider.dart';

class TransactionRepository {
  TransactionRepository({TransactionProvider? bookProvider})
      : _apiProvider = bookProvider ?? TransactionProvider();

  final TransactionProvider _apiProvider;

  Future getHistoryTransaction({required int userId}) async {
    final response = await _apiProvider.getHistoryTransaction(userId: userId);

    if (response is GetTransactionHistoryModelPack) {
      return response.data;
    } else {
      return response;
    }
  }

  Future createNewTransaction({
    required AddNewTransactionModel data,
  }) async {
    final response = await _apiProvider.createNewTransaction(data: data);

    return response;
  }
}
