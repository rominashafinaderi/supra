import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supra/api/dio/noteList/note_list_bloc.dart';

import 'package:supra/api/toekn_manager.dart';
import 'package:supra/colors.dart';
import 'package:supra/extensions.dart';
import 'package:supra/helpers.dart';
import 'package:supra/models/note_model.dart';
import 'package:supra/screen/add_note_screen.dart';
import 'package:supra/screen/login_screen.dart';
import 'package:supra/screen/update_note_screen.dart';
import 'package:supra/widget/note_card.dart';

import '../api/dio/auth/logout/logout_bloc.dart';


class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  NoteListBloc noteListBloc = NoteListBloc();
  LogoutBloc logoutBloc = LogoutBloc();
  @override
  void initState() {
    super.initState();
    noteListBloc.add(FetchNotes());
  }

  List<Note> notes = [];

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
          onPressed: () async{
            final token = await TokenManager.getAccessToken();
            print('token logout $token');
            logoutBloc.add(LogoutEvent(token: token!));
            pushAndRemoveUntil(context, LoginScreen(), (route)=>false);
          },
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
        onPressed: () async {
          final result = await push(context, AddNoteScreen());
          if (result == true) {
            noteListBloc.add(FetchNotes());
          }
        },
        child: Icon(
          Icons.add,
          color: white,
          size: 30,
        ),
      ),
      body:BlocConsumer<NoteListBloc, NoteListState>(
        bloc: noteListBloc,
        listener: (context, state) {
          if (state is NoteListSuccess) {
            setState(() {
              notes = state.notes;
            });
          }
        },
        builder: (context, state) {
          if (state is NoteListLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is NoteListError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is NoteListSuccess && state.notes.isNotEmpty) {
            return ListView.separated(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCard(
                  note: note,
                  onDeletePressed: () {
                    noteListBloc.add(DeleteNote(note.id));
                  },
                  onUpdatePressed: () async {
                    final result = await push(
                      context,
                      UpdateNoteScreen(
                        note: note,
                        onBtnUpdatePressed: () {},
                      ),
                    );

                    if (result is Note) {
                      setState(() {
                        notes[index] = result;
                      });
                    }
                  },
                );
              },
              separatorBuilder: (context, index) {
                return 10.height;
              },
            );
          }

          return Center(child: Text('No notes available'));
        },
      )

    );
  }
}
