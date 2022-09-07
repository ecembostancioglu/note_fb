import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_fb/constants/app_constants.dart';
import 'package:todo_fb/notes/data/repository/note_database.dart';

class NoteView extends StatefulWidget {
    NoteView({
     required this.data,
     required this.index,
      required this.id,
    Key? key,
  }) : super(key: key);

  final dynamic data;
  final int index;
  final String id;

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {

   NoteDatabase noteDatabase=NoteDatabase();
   Random random=Random();
   bool _isDeleting=false;

   final colors=const[
     Color(0xff645CAA),
     Color(0xffA084CA),
     Color(0xffBFACE0),
     Color(0xffEBC7E8),
     Color(0xffFFC4C4),
     Color(0xffAC7088),
   ];

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane:ActionPane(
          key:const ValueKey(0),
        motion:const ScrollMotion(),
        children:[
        SlidableAction(
          onPressed:((context)async{
          setState(() {
            _isDeleting=true;
          });
          await noteDatabase.deleteNote(id:widget.id);
          setState(() {
            _isDeleting=false;
          });
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
          decoration:BoxDecoration(
            color:colors[random.nextInt(6)],
              borderRadius: BorderRadius.all(
                  Radius.circular(AppConstants.borderRadius)),
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
