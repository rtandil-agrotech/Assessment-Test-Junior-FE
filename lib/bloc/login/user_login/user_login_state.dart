part of 'user_login_bloc.dart';

@immutable
abstract class UserLoginState {}

class UserLoginInitial extends UserLoginState {}

class UserLoginLoading extends UserLoginState {}

class UserLoginDone extends UserLoginState {}

class UserLoginFailed extends UserLoginState {
  final String errorMessage;

  UserLoginFailed({required this.errorMessage});
}
