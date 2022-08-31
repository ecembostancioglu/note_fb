import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/authentication/widgets/login_widget.dart';
import '../../widgets/add_note.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CollectionReference ref=FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: ()async{
              await Provider.of<AuthService>(context,listen: false).signOut().then((_)
              {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginWidget(),
                    ),
                        (Route route) => false);
              });

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
              padding:EdgeInsets.all(20),
             child: Text('WELCOME'),),
             Padding(
                padding: EdgeInsets.all(12.0),
                child: TextField(
                  onChanged:(val){},
                  decoration:const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    )
                  ),

                ),
              ),
            Flexible(
                child: FutureBuilder<QuerySnapshot>(
                  future: ref.get(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                     return ListView.builder(
                       itemCount: snapshot.data!.docs.length,
                         itemBuilder:(context,index){
                           return ListTile(
                             title:Text('${snapshot.data!.docs[index]['title']}'),
                             subtitle:Text('${snapshot.data!.docs[index]['description']}'),
                           );
                         });
                    }else{
                      return Center(
                          child: CircularProgressIndicator());
                    }
                  },
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>AddNote(),)
          ).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),


      ),
    );
  }
}
