import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_fb/onboarding_view/widgets/onboard_content.dart';

import '../constants/app_constants.dart';

class OnBoardView extends StatelessWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: OnboardContent(
          image: 'assets/images/image1.png',
          title: AppConstants.title1,
          description: AppConstants.description1),
      ),
    );

  }
}

