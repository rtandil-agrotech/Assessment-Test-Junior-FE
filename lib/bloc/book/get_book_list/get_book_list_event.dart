part of 'get_book_list_bloc.dart';

@immutable
abstract class GetBookListEvent {}

class GetBookListFromApi extends GetBookListEvent {}

class GetBookListFromApiNextPage extends GetBookListEvent {}

class GetBookListFromApiBySearch extends GetBookListEvent {
  final SearchByType param;

  GetBookListFromApiBySearch({required this.param});
}
