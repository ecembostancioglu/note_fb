import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/notes/presentation/view/home_page.dart';
import 'package:todo_fb/notes/presentation/view/settings.dart';
import '../../../constants/app_constants.dart';
import '../../database/provider/image_provider.dart';
import '../../widgets/add_note.dart';

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
  void initState() {
  Provider.of<UploadImageProvider>(context,listen:false).initSharedPreferences();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:  AppBar(
        title: Text('e-Daily'),
        backgroundColor:buttonColor,
      ),
      body: screens[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:FloatingActionButton(
            elevation: 10,
            backgroundColor:buttonColor,
            onPressed:(){
             Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>AddNote()));
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
       backgroundColor:navBarColor,
       selectedItemColor:buttonColor,
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
