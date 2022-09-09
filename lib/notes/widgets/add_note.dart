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
      appBar:AppBar(
        backgroundColor:Color(0xff645CAA),
        leading:IconButton(
            onPressed: (){
              Navigator.of(context).pop();},
            icon:const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
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


              icon: Text('Save'))
        ],
      ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _addNoteFromKey,
                  child:Column(
                    children: [
                      Padding(
                        padding:const EdgeInsets.all(20.0),
                        child: TextFormField(
                          decoration:const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                              hintText:'Title'),
                          onChanged: (val){
                            titleCtr.text=val;
                          },
                        ),
                      ),
                      Padding(
                        padding:const EdgeInsets.all(20.0),
                        child: TextFormField(
                          maxLines:22,
                          decoration:const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20))
                              ),
                              hintText:'Note Description'),
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
