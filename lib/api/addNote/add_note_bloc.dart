import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supra/api/noteList/note_list_bloc.dart';
import 'package:supra/api/response_extensions.dart';  // Import SharedPreferences

part 'add_note_event.dart';
part 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  AddNoteBloc() : super(AddNoteInitial()) {
    on(_onEvent);
  }

  Future _onEvent(AddNoteEvent event, Emitter<AddNoteState> emit) async {
    emit(AddNoteLoading());
    Response response;
    final url = Uri.parse('http://192.168.8.115:4000/posts');
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');  // Retrieve the token

      response = await http.post(url,
          body: jsonEncode({
            'title': event.title,
            'content': event.content
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'  // Add the token to the header
          });

      if (response.statusCode == 200) {
        emit(AddNoteSuccess());

      } else {
        emit(AddNoteError(response));
      }
    } catch (e) {
      print('add note catch error  :   $e');
    }
  }
}
