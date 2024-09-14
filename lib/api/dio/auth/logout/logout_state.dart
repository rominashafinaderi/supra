part of 'logout_bloc.dart';

 class LogoutState {}

final class LogoutInitial extends LogoutState {}
final class LogoutLoading extends LogoutState {}
final class LogoutSuccess extends LogoutState {}
final class LogoutError extends LogoutState {
   Response response;
    late String message;
    LogoutError(this.response){
      message = response.fetchMessage();
    }
}
