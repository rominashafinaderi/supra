part of 'note_list_bloc.dart';

abstract class NoteListState {}

class NoteListInitial extends NoteListState {}

class NoteListLoading extends NoteListState {}

class NoteListSuccess extends NoteListState {
  late final List<Note> notes;


    NoteListSuccess(Response response) {
      final data = response.data["data"];
      if (data is List) {
        notes = Note.fromList(data);
      } else {
        print('Error: Response data is not a list. Data: $data');
        notes = [];
      }
    }

}

class NoteListError extends NoteListState {
  late String message;

  NoteListError(Response response) {
    message = response.fetchMessage();
  }
}