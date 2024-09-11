part of 'note_list_bloc.dart';

abstract class NoteListEvent {}

class FetchNotes extends NoteListEvent {}
class DeleteNote extends NoteListEvent {
  final int noteId;

  DeleteNote(this.noteId);
}class UpdateNote extends NoteListEvent {
  final String title;
  final String content;
  final int noteId;

  UpdateNote(this.title,this.content,this.noteId);
}
