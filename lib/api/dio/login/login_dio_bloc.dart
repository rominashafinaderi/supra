import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_dio_event.dart';
part 'login_dio_state.dart';

class LoginDioBloc extends Bloc<LoginDioEvent, LoginDioState> {
  LoginDioBloc() : super(LoginDioInitial()) {
    on<LoginDioEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
