import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_fb/constants/app_constants.dart';
import 'package:todo_fb/notes/database/repository/note_database.dart';


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
        backgroundColor:buttonColor,
        actions: [
          IconButton(
            onPressed: ()async{
            var _selectedDate=await showDatePicker(
                  context: context,
                  initialDate:DateTime.now(),
                  firstDate:DateTime(-1000),
                  lastDate:DateTime.now());
            print(_selectedDate);
            },
            icon: Icon(Icons.calendar_month),
          )
        ],
        leading:IconButton(
            onPressed: (){
              Navigator.of(context).pop();},
            icon:const Icon(Icons.arrow_back_ios)),
      ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _addNoteFromKey,
              child:Column(
                children: [
                  Padding(
                    padding:const EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration:const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: borderRad
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
                              borderRadius:borderRad
                          ),
                          hintText:'Note Description'),
                      onChanged: (val){
                        descCtr.text=val;
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                          borderRadius:borderRad)),
                      minimumSize: MaterialStateProperty.all(Size(160.w,50.h)),
                      elevation: MaterialStateProperty.all(8),
                    backgroundColor:MaterialStateProperty.all(buttonColor)),
                      onPressed: ()async{
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
            ),
          ),
        ),
    );
  }
}
