import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supra/api/http/noteList/note_list_bloc.dart';
import 'package:supra/colors.dart';
import 'package:supra/extensions.dart';
import 'package:supra/models/note_model.dart';
import 'package:supra/widget/custom_btn.dart';
import 'package:supra/widget/custom_text_field.dart';


class UpdateNoteScreen extends StatefulWidget {
  const UpdateNoteScreen(
      {super.key, required this.note, this.onBtnUpdatePressed});

  final Note note;
  final VoidCallback? onBtnUpdatePressed;

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  NoteListBloc noteListBloc = NoteListBloc();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose(
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Update Notes',
          style: TextStyle(color: white),
        ),
        centerTitle: true,
        backgroundColor: darkPurple,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: white,
              size: 25,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              20.height,
              CustomTextField(
                label: 'title',
                controller: titleController,
              ),
              20.height,
              CustomTextField(
                label: 'description',
                maxLines: 20,
                controller: contentController,
              ),
              20.height,
              BlocConsumer<NoteListBloc, NoteListState>(
                bloc: noteListBloc,
                listener: (context, state) {
                  if (state is NoteListError) {
                    // toast message error
                  }
                  if (state is NoteListSuccess) {
                    widget.note.title = titleController.text.trim();
                    widget.note.content = contentController.text.trim();

                    Navigator.pop(context, widget.note);
                  }
                },
                builder: (context, state) {
                  if (state is NoteListLoading) {
                    return CircularProgressIndicator();
                  }

                  return customBtn('Update Note', () {
                    noteListBloc.add(UpdateNote(
                      titleController.text.trim(),
                      contentController.text.trim(),
                      widget.note.id,
                    ));
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
