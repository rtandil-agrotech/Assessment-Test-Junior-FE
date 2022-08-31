import 'package:flutter_modul_fe/models/book_model/book_list_model.dart';

class GetBookBySearchModelPack {
  final bool status;
  final int code;
  final String message;
  final List<GetBookBySearchData> data;

  GetBookBySearchModelPack({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetBookBySearchModelPack.fromJson(Map<String, dynamic> json) {
    List<GetBookBySearchData> temp = [];

    if (json['message'] == "Success") {
      for (Map<String, dynamic> data in json['data']) {
        temp.add(GetBookBySearchData.fromJson(data));
      }
    }

    return GetBookBySearchModelPack(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: temp,
    );
  }
}

class GetBookBySearchData extends GetBookListDataPerPageModel {
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

  GetBookBySearchData({
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
  }) : super(
          id: id,
          isbn: isbn,
          title: title,
          author: author,
          publicationYear: publicationYear,
          publisher: publisher,
          imageS: imageS,
          imageM: imageM,
          imageL: imageL,
          stok: stok,
          averageRating: averageRating,
          ratingCount: ratingCount,
        );

  factory GetBookBySearchData.fromJson(Map<String, dynamic> json) {
    double avgRating;

    if (json['average_ratting'].runtimeType == int) {
      avgRating = json['average_ratting'].toDouble();
    } else {
      avgRating = json['average_ratting'];
    }

    return GetBookBySearchData(
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
