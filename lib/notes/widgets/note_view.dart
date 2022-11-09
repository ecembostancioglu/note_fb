import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_fb/constants/app_constants.dart';
import 'package:todo_fb/notes/database/repository/note_database.dart';


class NoteView extends StatefulWidget {
   const NoteView({
     required this.data,
     Key? key,
  }) : super(key: key);

  final dynamic data;

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {

   NoteDatabase noteDatabase=NoteDatabase();
   Random random=Random();
   bool _isDeleting=false;

   Future<void> deleteNote()async{
     setState(() {
       _isDeleting=true;
     });
     await noteDatabase.deleteNote(id:widget.data.id);

     if(mounted){
       setState(() {
         _isDeleting=false;
       });
     }

   }


  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane:ActionPane(
        motion:const ScrollMotion(),
          children:[
        SlidableAction(
          onPressed:(context){
            deleteNote();
            Flushbar(
              icon:const Icon(Icons.delete_forever,color: Colors.white),
              flushbarStyle:FlushbarStyle.FLOATING,
              backgroundColor: Colors.black87,
              message: AppConstants.flushBar,
              duration:const Duration(seconds:4),
            ).show(context);
            },
          borderRadius:const BorderRadius.all(Radius.circular(20)),
          backgroundColor:errorBackground,
          foregroundColor:iconForeground,
          icon: Icons.delete,
          label: 'Delete',
        ),]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100.h,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              Card(
                elevation: 6,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${widget.data['title']}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap:false,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:18.sp),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${widget.data['description']}',
                        style: TextStyle(fontSize:16.sp),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap:false,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom:-35,right:-90,
                child: CircleAvatar(
                  radius: 70.r,
                  backgroundColor: colors[random.nextInt(4)],
                ))
            ],
          ),
        )
      ),
    );
  }
}
