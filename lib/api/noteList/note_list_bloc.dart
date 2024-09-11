import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supra/api/response_extensions.dart';
import 'package:supra/models/note_model.dart';

part 'note_list_event.dart';

part 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  NoteListBloc() : super(NoteListInitial()) {
    on<FetchNotes>(_onNoteList);
    on<DeleteNote>(_onDeleteNote);
    on<UpdateNote>(_onUpdateNote);
  }

  Future<void> _onNoteList(
    FetchNotes event,
    Emitter<NoteListState> emit,
  ) async {
    emit(NoteListLoading());

    final url = Uri.parse('http://192.168.8.115:4000/posts');
    Response response;
    try {
      response = await http.get(
        url,
        headers: {
          'Accept-Charset': 'utf-8',
        },
      );
      if (response.statusCode == 200) {
        emit(NoteListSuccess(response));
      } else {
        emit(NoteListError(response));
      }
    } catch (e) {
      print('Error in getting note list: $e');
    }
  }

  Future<void> deleteNoteApi(int noteId) async {
    final url = Uri.parse('http://192.168.8.115:4000/posts/$noteId');
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken'); // Retrieve the token
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token' // Add the token to the header
        },
      );
      if (response.statusCode != 200) {
        print('Error in delete API call: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in delete API call: $e');
    }
  }

  Future<void> _onDeleteNote(
    DeleteNote event,
    Emitter<NoteListState> emit,
  ) async {
    emit(NoteListLoading());

    try {
      await deleteNoteApi(event.noteId);
      await _onNoteList(FetchNotes(), emit);
    } catch (e) {
      print('Error in delete note list: $e');
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteListState> emit) async {
    emit(NoteListLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      final url = Uri.parse('http://192.168.8.115:4000/posts/${event.noteId}');
      final response = await http.patch(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token' // Add the token to the header
      }, body: jsonEncode({
        'title': event.title,
        'content': event.content,
      }),);
      final body = jsonEncode({
        'title': event.title,
        'content': event.content,
      });
      print('Request body: $body');

      if (response.statusCode == 200) {
        await _onNoteList(FetchNotes(), emit);
      } else {
        print('Error in update API call: ${response.reasonPhrase}');
        emit(NoteListError(response));
      }
    } catch (e) {
      print('Error in update API call: $e');
    }
  }
}
