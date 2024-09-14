part of 'add_note_bloc.dart';

 class AddNoteState {}

final class AddNoteInitial extends AddNoteState {}
final class AddNoteLoading extends AddNoteState {}
final class AddNoteError extends AddNoteState {
   Response response;
  late String message;
   AddNoteError(this.response){
     message = response.fetchMessage();
   }

}
final class AddNoteSuccess extends AddNoteState {}
