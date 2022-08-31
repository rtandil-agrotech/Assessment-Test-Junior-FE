part of 'get_book_list_settings_cubit.dart';

abstract class GetBookListSettingsState extends Equatable {
  const GetBookListSettingsState();

  @override
  List<Object> get props => [];
}

class GetBookListSettingsInitial extends GetBookListSettingsState {}

class GetBookListSettingsLoading extends GetBookListSettingsState {}

class GetBookListSettingsDone extends GetBookListSettingsState {}
