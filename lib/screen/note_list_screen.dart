import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supra/api/noteList/note_list_bloc.dart';
import 'package:supra/colors.dart';
import 'package:supra/extensions.dart';
import 'package:supra/helpers.dart';
import 'package:supra/models/note_model.dart';
import 'package:supra/screen/add_note_screen.dart';
import 'package:supra/widget/note_card.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  late NoteListBloc noteListBloc;

  @override
  void initState() {
    super.initState();
    noteListBloc = NoteListBloc();
    noteListBloc.add(FetchNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(color: white),
        ),
        centerTitle: true,
        backgroundColor: darkPurple,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.exit_to_app_outlined,
            color: white,
            size: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: white,
              size: 25,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkPurple,
        onPressed: () {
          push(context, AddNoteScreen());
        },
        child: Icon(
          Icons.add,
          color: white,
          size: 30,
        ),
      ),
      body: BlocBuilder<NoteListBloc, NoteListState>(
        bloc: noteListBloc,
        builder: (context, state) {
          if (state is NoteListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NoteListError) {
            return Center(
              child: Text('Error: ${state.message}'), // نمایش پیام خطا
            );
          } else if (state is NoteListSuccess) {
            return ListView.separated(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final noteModel = state.notes[index];
                return NoteCard(note: noteModel);
              },
              separatorBuilder: (context, index) {
                return 10.height;
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
