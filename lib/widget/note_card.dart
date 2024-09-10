import 'package:flutter/material.dart';
import 'package:supra/colors.dart';
import 'package:supra/extensions.dart';
import 'package:supra/models/note_model.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({super.key, required this.note});

  final Note note;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.note.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                    maxLines: 1,
                  ),
                  10.height,
                  Text(
                    widget.note.content,
                    style: TextStyle(fontSize: 13),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit, color: darkPurple),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete_rounded,
                          color: darkPurple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
