import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_fb/constants/app_constants.dart';
import 'package:todo_fb/notes/data/repository/note_database.dart';

import '../domain/models/note.dart';

class NoteView extends StatefulWidget {
    NoteView({
     required this.data,
     required this.index,
    Key? key,
  }) : super(key: key);

  final dynamic data;
  final int index;

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {

   NoteDatabase noteDatabase=NoteDatabase();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane:ActionPane(
          key:const ValueKey(0),
        motion:const ScrollMotion(),
        children:[
        SlidableAction(
          onPressed:((context){
            deleteNote(Note note){
              noteDatabase.deleteDocument(
                  AppConstants.referencePath,AppConstants.collectionPath,widget.index.toString());
            }
          }),
          backgroundColor:const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 80.h,
          width: ScreenUtil().screenWidth,
          decoration:const BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppConstants.borderRadius)),
              gradient: LinearGradient(
                  colors:[
                    Colors.blueGrey,
                    Colors.blueAccent]
              )
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${widget.data['title']}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:18.sp),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${widget.data['description']}',
                    style: TextStyle(fontSize:16.sp)),
              ),
            ],
          ) ,
        ),
      ),
    );
  }
}
