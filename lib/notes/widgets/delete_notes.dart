import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../database/repository/note_database.dart';

class DeleteAllNotes extends StatefulWidget {
  DeleteAllNotes({
    Key? key,
    required this.noteDatabase,
    required bool isDeleted,
  }) : isDeleted = isDeleted, super(key: key);

  final NoteDatabase noteDatabase;
  bool isDeleted;

  @override
  State<DeleteAllNotes> createState() => _DeleteAllNotesState();
}

class _DeleteAllNotesState extends State<DeleteAllNotes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Delete all notes'),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:MaterialStateProperty
                      .all(buttonColor)),
              onPressed:(){
                widget.noteDatabase.deleteAllNotes();
                setState(() {
                  widget.isDeleted=true;
                });
              },
              child:widget.isDeleted==false
                  ? Text('DELETE')
                  : Icon(Icons.check)),
        ],
      ),
    );
  }
}