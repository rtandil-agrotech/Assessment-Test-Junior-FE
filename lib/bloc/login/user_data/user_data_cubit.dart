import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modul_fe/models/login_model/login_model.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataState(userData: null));

  void updateUserLoginData(LoginData data) {
    emit(UserDataState(userData: data));
  }
}
