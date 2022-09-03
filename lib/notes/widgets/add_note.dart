import 'package:flutter/material.dart';
import 'package:todo_fb/constants/app_constants.dart';
import 'package:todo_fb/notes/data/repository/note_database.dart';
import '../domain/models/note.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  TextEditingController titleCtr=TextEditingController();
  TextEditingController descCtr=TextEditingController();

  NoteDatabase database=NoteDatabase();


Future<void> add(String title,String description,DateTime created)async{
   Note newNote=Note(
       title: title,
       description: description,
       created: created);
   await database.setNote(
        referencePath:AppConstants.referencePath,
       collectionPath:AppConstants.collectionPath,
       noteAsMap:newNote.toMap());

   Navigator.pop(context);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pop();},
                        child: Icon(Icons.arrow_back_ios)),
                    ElevatedButton(
                        onPressed:(){
                          add(titleCtr.text,
                              descCtr.text,
                              DateTime.now());
                        },
                         child: Text('Save'))
                  ],
                ),
                Form(
                  child:Column(
                    children: [
                      Padding(
                        padding:const EdgeInsets.all(20.0),
                        child: TextFormField(
                          decoration:const InputDecoration(
                              hintText:'Title',
                              prefixIcon: Icon(Icons.note_add)),
                          onChanged: (val){
                            titleCtr.text=val;
                          },
                        ),
                      ),
                      Padding(
                        padding:const EdgeInsets.all(20.0),
                        child: TextFormField(
                          decoration:const  InputDecoration(
                              hintText:'Note Description',
                              prefixIcon: Icon(Icons.description)),
                          onChanged: (val){
                            descCtr.text=val;
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
