part of 'get_book_list_additional_cubit.dart';

abstract class GetBookListAdditionalState extends Equatable {
  const GetBookListAdditionalState();

  @override
  List<Object> get props => [];
}

class GetBookListAdditionalInitial extends GetBookListAdditionalState {}

class GetBookListAdditionalLoading extends GetBookListAdditionalState {}

class GetBookListAdditionalDone extends GetBookListAdditionalState {}

class GetBookListAdditionalFailed extends GetBookListAdditionalState {}
