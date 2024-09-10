import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:supra/api/response_extensions.dart';
import 'package:supra/models/note_model.dart';

part 'note_list_event.dart';
part 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  NoteListBloc() : super(NoteListInitial()) {
    on<FetchNotes>(_onNoteList);
  }

  Future<void> _onNoteList(
      FetchNotes event, Emitter<NoteListState> emit) async {
    emit(NoteListLoading());

    final url = Uri.parse('http://192.168.8.115:4000/posts');
    Response response;
    try {
      response = await http.get(url,headers: {
        'Accept-Charset': 'utf-8',
      });
      if (response.statusCode == 200) {
        emit(NoteListSuccess(response));
      } else {
        emit(NoteListError(response));
      }
    } catch (e) {
      print('Error in getting note list: $e');
      emit(NoteListError(Response('Error', 500))); // ایجاد یک Response فرضی برای ارسال Error
    }
  }
}
