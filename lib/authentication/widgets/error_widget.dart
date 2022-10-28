import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

void displayErrorToast(BuildContext context,String description)  {
   MotionToast.error(
     title:const Text('Error',
       style: TextStyle(
           fontWeight: FontWeight.bold
       ),),
    description:Text(description),
    animationType:AnimationType.fromLeft,
    position:MotionToastPosition.bottom,
    barrierColor:Colors.black.withOpacity(0.3),
    width: 350.w,
    height:80.h,
    toastDuration:const Duration(seconds: 3),
  ).show(context);
}
