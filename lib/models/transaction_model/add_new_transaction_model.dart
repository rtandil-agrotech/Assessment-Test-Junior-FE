import 'package:intl/intl.dart';

class AddNewTransactionModel {
  final int userId;
  final DateTime returnDate;

  AddNewTransactionModel({
    required this.userId,
    required this.returnDate,
  });

  Map<String, dynamic> toJson() {
    String dateTime = DateFormat("yyyy-MM-dd").format(returnDate);

    return {
      "user_id": userId,
      "return_date": dateTime,
    };
  }
}
