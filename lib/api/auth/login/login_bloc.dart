import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supra/api/response_extensions.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on(_onLoginEvent);
  }

  Future  _onLoginEvent(LoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    Response response;
    final url = Uri.parse('http://192.168.8.115:4000/auth/login');
    try {
      response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': event.email,
            'password': event.password,
            'fingerprint': event.fingerprint
          }));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        emit(LoginSuccessState());
        final data = jsonDecode(response.body);
        final token = data["data"]['accessToken'];
        print('tokeeen:$token');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', token);
      } else {
        emit(LoginErrorState(response));
      }
    } catch (e) {
      print('Request failed: $e');
    }
  }
}
