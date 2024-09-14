import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supra/api/response_extensions.dart';
import 'package:supra/api/toekn_manager.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on(_onLoginEvent);
  }

  Future _onLoginEvent(LoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    Response response;
    Dio dio = Dio();

    final url = 'http://192.168.8.115:4000/auth/login';
    try {
      response = await dio.post(url,
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: {
            'email': event.email,
            'password': event.password,
            'fingerprint': event.fingerprint
          });

      if (response.statusCode == 200) {
        emit(LoginSuccessState());
        print('adsdffd');

        final data = response.data;

        await TokenManager.saveAccessToken(data["data"]['accessToken']);
        await TokenManager.saveRefreshToken(data["data"]['refreshToken']);
      } else {
        emit(LoginErrorState(response));
      }
    } catch (e) {
      print('Request failed: $e');
    }
  }
}
