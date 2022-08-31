enum SearchType {
  title,
  author,
  isbn,
}

class SearchByType {
  final SearchType searchType;
  final String param;

  SearchByType({
    required this.searchType,
    required this.param,
  });

  static String convertValueForUi(SearchType type) {
    switch (type) {
      case SearchType.title:
        return "Book Title";
      case SearchType.author:
        return "Author";
      case SearchType.isbn:
        return "ISBN";
    }
  }
}
