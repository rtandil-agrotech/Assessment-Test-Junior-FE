part of 'user_login_bloc.dart';

@immutable
abstract class UserLoginEvent {}

class DoAuthenticateUser extends UserLoginEvent {
  final LoginPostModel data;

  DoAuthenticateUser({required this.data});
}
