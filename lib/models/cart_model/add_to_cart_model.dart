class AddBookToCartModel {
  final int userId;
  final int bookId;

  AddBookToCartModel({
    required this.userId,
    required this.bookId,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "book_id": bookId,
    };
  }
}
