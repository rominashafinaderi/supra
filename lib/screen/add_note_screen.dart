import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supra/api/http/addNote/add_note_bloc.dart';
import 'package:supra/colors.dart';
import 'package:supra/extensions.dart';
import 'package:supra/widget/custom_btn.dart';
import 'package:supra/widget/custom_text_field.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  late AddNoteBloc addNoteBloc;

  @override
  void initState() {
    super.initState();
    addNoteBloc = AddNoteBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Add Notes',
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
              BlocConsumer(
                bloc: addNoteBloc,
                listener: (context, state) {
                  if (state is AddNoteSuccess) {
                    Navigator.pop(context,true);
                  }
                  if (state is AddNoteError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
                  }
                },
                builder: (context, state) {
                  if (state is AddNoteLoading) {
                    return CircularProgressIndicator();
                  }
                  return customBtn('Add Note', () {
                    addNoteBloc.add(AddNoteEvent(
                      title: titleController.text,
                      content: contentController.text,
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
