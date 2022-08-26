import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/authentication/widgets/login_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> notes=['One','Two','Three','Four','Five','Six','Seven','Eight','Nine','Ten'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: (){
              AuthService auth=AuthService();
              auth.signOutFromGoogle();
              FirebaseAuth.instance.signOut();

              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>LoginWidget()));
            },
          )
        ],
      ),
      body: SizedBox(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
             child: Text('WELCOME'),),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  decoration:const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    )
                  ),

                ),
              ),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                itemCount: notes.length,
                  itemBuilder: (context,index){
                return ListTile(
                  title: Text(notes[index]),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
