import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../authentication/presentation/view/auth_page.dart';
import '../../authentication/service/auth_service.dart';

class SignOutWidget extends StatelessWidget {
  const SignOutWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sign Out'),
            IconButton(
              icon:const Icon(Icons.logout),
              onPressed: ()async{
                await Provider.of<AuthService>(context,listen: false).signOut().then((_)
                {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(
                      builder: (context)=>AuthPage()));
                });
              },
            ),
          ],
        )
    );
  }
}