part of 'note_list_bloc.dart';

abstract class NoteListState {}

class NoteListInitial extends NoteListState {}

class NoteListLoading extends NoteListState {}

class NoteListSuccess extends NoteListState {
  late final List<Note> notes;

  NoteListSuccess(Response response) {
    notes = Note.fromList(response.fetchData());
  }
}

class NoteListError extends NoteListState {
  late String message;

  NoteListError(Response response) {
    message = response.fetchMessage();
  }
}