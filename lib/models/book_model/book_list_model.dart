class GetBookListModelPack {
  final bool status;
  final int code;
  final String message;
  final GetBookListDataModel data;

  GetBookListModelPack({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetBookListModelPack.fromJson(Map<String, dynamic> json) {
    return GetBookListModelPack(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: GetBookListDataModel.fromJson(json['data']),
    );
  }
}

class GetBookListDataModel {
  final int currentPage;
  final int totalPage;
  final int totalData;
  final List<GetBookListDataPerPageModel> dataPerPage;

  GetBookListDataModel({
    required this.currentPage,
    required this.totalPage,
    required this.totalData,
    required this.dataPerPage,
  });

  factory GetBookListDataModel.fromJson(Map<String, dynamic> json) {
    List<GetBookListDataPerPageModel> temp = [];

    for (Map<String, dynamic> bookData in json['data_per_page']) {
      temp.add(GetBookListDataPerPageModel.fromJson(bookData));
    }

    return GetBookListDataModel(
      currentPage: json['current_page'],
      totalPage: json['total_page'],
      totalData: json['total_data'],
      dataPerPage: temp,
    );
  }
}

class GetBookListDataPerPageModel {
  final int id;
  final String isbn;
  final String title;
  final String author;
  final int publicationYear;
  final String publisher;
  final String imageS;
  final String imageM;
  final String imageL;
  final int stok;
  final double averageRating;
  final int ratingCount;

  GetBookListDataPerPageModel({
    required this.id,
    required this.isbn,
    required this.title,
    required this.author,
    required this.publicationYear,
    required this.publisher,
    required this.imageS,
    required this.imageM,
    required this.imageL,
    required this.stok,
    required this.averageRating,
    required this.ratingCount,
  });

  factory GetBookListDataPerPageModel.fromJson(Map<String, dynamic> json) {
    double avgRating;

    if (json['average_ratting'].runtimeType == int) {
      avgRating = json['average_ratting'].toDouble();
    } else {
      avgRating = json['average_ratting'];
    }

    return GetBookListDataPerPageModel(
      id: json['id'],
      isbn: json['isbn'],
      title: json['title'],
      author: json['author'],
      publicationYear: json['publication_year'],
      publisher: json['publisher'],
      imageS: json['image_s'],
      imageM: json['image_m'],
      imageL: json['image_l'],
      stok: json['stok'],
      averageRating: avgRating,
      ratingCount: json['rattings_count'],
    );
  }
}
