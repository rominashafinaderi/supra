import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:supra/api/response_extensions.dart';
import 'package:supra/api/toekn_manager.dart';
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

    final url = 'http://192.168.8.115:4000/posts';
    Response response;
    Dio dio= Dio();
    try {
      response = await dio.get(
        url,
          options: Options(headers:  {
          'Accept-Charset': 'utf-8',
        },
      ));
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
    Dio dio= Dio();

    final url = 'http://192.168.8.115:4000/posts/$noteId';
    try {
      final token = await TokenManager.getAccessToken();
      print("ddddddddddddd :$token");
      final response = await dio.delete(
        url,
          options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token' // Add the token to the header
        },
      ));
      if (response.statusCode != 200) {
        print('Error in delete API call: ${response.statusMessage}');
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
    Dio dio= Dio();

    try {
      final token = await TokenManager.getAccessToken();

      final url = 'http://192.168.8.115:4000/posts/${event.noteId}';
      final response = await dio.patch(url,  options: Options(headers:  {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token' // Add the token to the header
      }), data: {
        'title': event.title,
        'content': event.content,
      },);

      if (response.statusCode == 200) {
        await _onNoteList(FetchNotes(), emit);
      } else {
        print('Error in update API call: ${response.statusMessage}');
        emit(NoteListError(response));
      }
    } catch (e) {
      print('Error in update API call: $e');
    }
  }
}
