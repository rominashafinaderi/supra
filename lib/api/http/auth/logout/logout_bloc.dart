import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:supra/api/response_extensions.dart';

part 'logout_event.dart';

part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent,LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutEvent>(_onLogOut);
  }

  Future<void> _onLogOut(LogoutEvent event, Emitter<LogoutState> emit) async {
    emit(LogoutLoading());
    final url = Uri.parse('http://192.168.8.115:4000/auth/logout');


    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${event.token}'
    });
    if(response.statusCode ==200){
      emit(LogoutSuccess());
    }
    emit(LogoutError(response));
  }
}
