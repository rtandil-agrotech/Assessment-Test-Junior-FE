class GetTransactionHistoryModelPack {
  final bool status;
  final int code;
  final String message;
  final List<GetTransactionHistoryDataModel> data;

  GetTransactionHistoryModelPack({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetTransactionHistoryModelPack.fromJson(Map<String, dynamic> json) {
    List<GetTransactionHistoryDataModel> temp = [];

    if (json['message'] == "Success") {
      for (Map<String, dynamic> data in json['data']) {
        temp.add(GetTransactionHistoryDataModel.fromJson(data));
      }
    }

    return GetTransactionHistoryModelPack(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: temp,
    );
  }
}

class GetTransactionHistoryDataModel {
  final int transactionId;
  final DateTime borrowedTime;
  final List<GetTransactionHistoryBookDataModel> bookData;

  GetTransactionHistoryDataModel({
    required this.transactionId,
    required this.borrowedTime,
    required this.bookData,
  });

  factory GetTransactionHistoryDataModel.fromJson(Map<String, dynamic> json) {
    List<GetTransactionHistoryBookDataModel> temp = [];
    DateTime borrowedTime = DateTime.parse(json['borrowed_time']);

    for (Map<String, dynamic> bookData in json['book_data']) {
      temp.add(GetTransactionHistoryBookDataModel.fromJson(bookData));
    }

    return GetTransactionHistoryDataModel(
      transactionId: json['transaction_id'],
      borrowedTime: borrowedTime,
      bookData: temp,
    );
  }
}

class GetTransactionHistoryBookDataModel {
  final int id;
  final bool returnStatus;
  final DateTime returnDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int transactionId;
  final int bookId;
  final int userId;
  final String title;
  final String imageM;
  final String author;
  final double averageRating;
  final int ratingCount;

  GetTransactionHistoryBookDataModel({
    required this.id,
    required this.returnStatus,
    required this.returnDate,
    required this.createdAt,
    required this.updatedAt,
    required this.transactionId,
    required this.bookId,
    required this.userId,
    required this.title,
    required this.imageM,
    required this.author,
    required this.averageRating,
    required this.ratingCount,
  });

  factory GetTransactionHistoryBookDataModel.fromJson(
      Map<String, dynamic> json) {
    double avgRating;
    DateTime returnDate = DateTime.parse(json['return_date']);
    DateTime createdAt = DateTime.parse(json['created_at']);
    DateTime updatedAt = DateTime.parse(json['updated_at']);

    if (json['average_ratting'].runtimeType == int) {
      avgRating = json['average_ratting'].toDouble();
    } else {
      avgRating = json['average_ratting'];
    }

    return GetTransactionHistoryBookDataModel(
      id: json['id'],
      returnStatus: json['return_status'],
      returnDate: returnDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      transactionId: json['transaction_id'],
      bookId: json['book_id'],
      userId: json['user_id'],
      title: json['title'],
      imageM: json['image_m'],
      author: json['author'],
      averageRating: avgRating,
      ratingCount: json['rattings_count'],
    );
  }
}
