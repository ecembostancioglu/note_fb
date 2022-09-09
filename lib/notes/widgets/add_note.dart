import 'package:flutter/material.dart';
import 'package:todo_fb/notes/data/repository/note_database.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final _addNoteFromKey=GlobalKey<FormState>();
  TextEditingController titleCtr=TextEditingController();
  TextEditingController descCtr=TextEditingController();

  NoteDatabase database=NoteDatabase();
  bool _isProcessing=false;


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
                        child:const Icon(Icons.arrow_back_ios)),
                    ElevatedButton(
                        onPressed:()async{
                          if(_addNoteFromKey.currentState!.validate()){
                            setState(() {
                              _isProcessing=true;
                            });
                          }
                        await database.addNote(
                              titleCtr.text,
                              descCtr.text,
                              DateTime.now());
                          
                          setState(() {
                            _isProcessing=false;
                          });
                          Navigator.pop(context);
                          },
                       

                         child: Text('Save'))
                  ],
                ),
                Form(
                  key: _addNoteFromKey,
                  child:Column(
                    children: [
                      Padding(
                        padding:const EdgeInsets.all(20.0),
                        child: TextFormField(
                          decoration:InputDecoration(
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
                          decoration:const InputDecoration(
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
