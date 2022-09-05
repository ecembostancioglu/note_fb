import 'package:flutter/material.dart';
import 'package:todo_fb/notes/domain/models/auth_user.dart';
import 'package:todo_fb/notes/presentation/view/home_page.dart';
import 'package:todo_fb/notes/presentation/view/settings.dart';
import '../../widgets/add_note.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({required this.name,Key? key}) : super(key: key);

  final String name;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex=0;
  final screens=[
    HomePage(name:AuthUser.userName),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Color(0xff645CAA),
        onPressed:(){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>AddNote())
          ).then((value) {
            setState(() {});
          });
        },
        child:const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey.shade600,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels:false,
        currentIndex: currentIndex,
        onTap:(index) =>
            setState(() {
          currentIndex=index;
        }),
        elevation:10,
       backgroundColor:const Color(0xffEBC7E8),
       selectedItemColor:const Color(0xff645CAA),
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
