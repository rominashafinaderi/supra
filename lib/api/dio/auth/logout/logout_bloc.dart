import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:supra/api/response_extensions.dart';
import 'package:supra/api/toekn_manager.dart';

part 'logout_event.dart';

part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutEvent>(_onLogOut);
  }

  Future<void> _onLogOut(LogoutEvent event, Emitter<LogoutState> emit) async {
    emit(LogoutLoading());
    final url = 'http://192.168.8.115:4000/auth/logout';

    Dio dio = Dio();
    try {
      final refreshToken = await TokenManager.getRefreshToken();

      final response = await dio.post(
        url,
        data: {
          "refreshToken":refreshToken,
        },

        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${event.token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        emit(LogoutSuccess());
        await TokenManager.removeTokens();

      } else {
        emit(LogoutError(response));
      }
    } catch (e) {
      print("log  out $e");
    }
  }
}
