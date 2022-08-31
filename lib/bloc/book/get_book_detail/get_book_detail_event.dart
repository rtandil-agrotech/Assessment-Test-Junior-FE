part of 'get_book_detail_bloc.dart';

@immutable
abstract class GetBookDetailEvent {}

class GetBookDetailFromApi extends GetBookDetailEvent {
  final int id;

  GetBookDetailFromApi({required this.id});
}
