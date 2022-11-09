import 'package:flutter/material.dart';
import 'package:todo_fb/notes/presentation/view/home_page.dart';
import 'package:todo_fb/notes/presentation/view/settings.dart';
import '../../../constants/app_constants.dart';
import 'add_note.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);


  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex=0;
  final screens=[
    HomePage(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:  AppBar(
        backgroundColor:buttonColor,
      ),
      body: screens[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:FloatingActionButton(
            elevation: 10,
            backgroundColor:floatingButtonColor,
            onPressed:(){
             Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>AddNote()));
            },
              child:const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels:false,
        currentIndex: currentIndex,
        onTap:(index) =>
            setState(() {
          currentIndex=index;
        }),
        elevation:10,
       backgroundColor:navBarColor,
       selectedItemColor:Colors.white,
       items:const [
         BottomNavigationBarItem(
             icon: Icon(Icons.home),
         label: 'Home'),
         BottomNavigationBarItem(
             icon: Icon(Icons.settings),
         label: 'Settings'),

       ],
      ),
    );
  }
}
