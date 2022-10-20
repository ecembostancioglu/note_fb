import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String image;
  final String title;
  final String description;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Center(
          child: Image.asset(image,
            alignment: Alignment.center,
            height:240.h,
          ),
        ),
        const Spacer(),
        Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24.sp),
        ),
        Text(description,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16.sp),
        ),
        const Spacer(),
      ],
    );
  }
}