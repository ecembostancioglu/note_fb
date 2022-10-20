import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardView extends StatelessWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: Image.asset('assets/images/image1.png',
                  alignment: Alignment.center,
                  height:250.h,
              ),
            ),
            const Spacer(),
            Text('Take Notes',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.sp),
            ),
            Text('Take notes and capture ideas \nat a moment notice...',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.sp,),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
