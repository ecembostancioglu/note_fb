import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_constants.dart';
import '../../database/repository/note_database.dart';
import '../../domain/models/note.dart';
import '../../services/calculator.dart';


class UpdateNote extends StatefulWidget {
   UpdateNote({Key? key,required this.noteId}) : super(key: key);

   var noteId;

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {

  final _updateNoteFromKey=GlobalKey<FormState>();

  NoteDatabase database=NoteDatabase();
  bool isProcessing=false;
  String? updateFinishDate;
  Note? note;


  Future<void> updateNote() async{
    if(_updateNoteFromKey.currentState!.validate()){
      setState(() {
        isProcessing=true;
      });
    }
    await database.updateNote(
        updateTitleCtr.text,
        updateDescCtr.text,
        DateTime.now(),
        updateFinishDate,
        widget.noteId

    );
    if(mounted){
      setState(() {
        isProcessing=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:buttonColor,
        actions: [
          IconButton(
            onPressed: ()async{
              var selectedDate=await showDatePicker(
                  context: context,
                  initialDate:DateTime.now(),
                  firstDate:DateTime(-1000),
                  lastDate:DateTime(3000));
              updateFinishDate=Calculator.dateTimeToString(selectedDate!);
            },
            icon: const Icon(Icons.calendar_month),
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
            key: _updateNoteFromKey,
            child:Column(
              children: [
                Padding(
                  padding:const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller:titleCtr,
                    decoration:const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: borderRad
                        ),
                        hintText:'Title'),
                    onChanged:(val){
                  //    titleCtr.text=val;
                      updateTitleCtr.value= TextEditingController.fromValue(TextEditingValue(text:titleCtr.text)).value;
                    },
                  ),
                ),
                Padding(
                  padding:const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller:descCtr,
                    maxLines:22,
                    decoration:const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:borderRad
                        ),
                        hintText:'Note Description'),
                    onChanged: (val){
                      updateDescCtr.value= TextEditingController.fromValue(TextEditingValue(text:descCtr.text)).value;
                    },
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:borderRad)),
                        minimumSize: MaterialStateProperty.all(Size(160.w,50.h)),
                        elevation: MaterialStateProperty.all(8),
                        backgroundColor:MaterialStateProperty.all(buttonColor)),
                    onPressed:(){
                      updateNote();
                      Navigator.pop(context);
                    },
                    child: const Text('Update'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}