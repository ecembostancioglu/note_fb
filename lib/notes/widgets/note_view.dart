import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_fb/constants/app_constants.dart';

class NoteView extends StatelessWidget {
  const NoteView({
    required this.data,
    Key? key,
  }) : super(key: key);

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                Colors.blueAccent] )

        ),
      ),
    );
  }
}

//Text('${data['title']}')
//Text('${data['description']}')