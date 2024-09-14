part of 'login_bloc.dart';

@immutable
class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginErrorState extends LoginState {
  late String message;
Response response;
  LoginErrorState(this.response) {
    message = response.fetchMessage();
  }
}

final class LoginSuccessState extends LoginState {}
