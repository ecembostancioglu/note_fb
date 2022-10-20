import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_fb/onboarding_view/widgets/dot_indicator.dart';
import 'package:todo_fb/onboarding_view/widgets/onboard_content.dart';
import 'models/onboard.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  late PageController _pageController;
  int _pageIndex=0;

  @override
  void initState() {
    _pageController=PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount:contents.length,
                  controller: _pageController,
                  onPageChanged: (index){
                    setState(() {
                      _pageIndex=index;
                    });
                  },
                  itemBuilder: (context,index)=>
                      OnboardContent(
                          image:contents[index].image,
                          title:contents[index].title,
                          description:contents[index].description),
                ),
              ),
              Row(
                children: [
                  ...List.generate(contents.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: DotIndicator(isActive: index==_pageIndex),

                          )),
                  const Spacer(),
                  SizedBox(
                    height: 50.h,
                    width: 50.w,
                    child: Padding(
                      padding:EdgeInsets.only(bottom:5.h),
                      child: ElevatedButton(
                        onPressed: (){
                          _pageController.nextPage(
                              duration:const Duration(milliseconds:400),
                              curve: Curves.ease);
                        },
                        style: ElevatedButton.styleFrom(
                          shape:const CircleBorder(),
                            elevation: 10,
                        ),
                        child:const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

  }
}

