import 'package:bloc/bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/models/login_model/login_model.dart';
import 'package:flutter_modul_fe/models/login_model/login_post_model.dart';
import 'package:flutter_modul_fe/repositories/login_repository/login_exceptions.dart';
import 'package:flutter_modul_fe/repositories/login_repository/login_repository.dart';
import 'package:meta/meta.dart';

part 'user_login_event.dart';
part 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final LoginRepository _repository = LoginRepository();
  final UserDataCubit userDataCubit;

  UserLoginBloc({required this.userDataCubit}) : super(UserLoginInitial()) {
    on<DoAuthenticateUser>((event, emit) async {
      emit(UserLoginLoading());

      try {
        LoginData loginData =
            await _repository.userLogin(loginData: event.data);

        userDataCubit.updateUserLoginData(loginData);

        emit(UserLoginDone());
      } catch (exception) {
        if (exception is WrongEmailLoginFailed) {
          emit(UserLoginFailed(errorMessage: "Wrong Email"));
        } else if (exception is WrongPasswordLoginFailed) {
          emit(UserLoginFailed(errorMessage: "Wrong Password"));
        } else {
          emit(UserLoginFailed(errorMessage: "Wrong Email or Password"));
        }
      }
    });
  }
}
