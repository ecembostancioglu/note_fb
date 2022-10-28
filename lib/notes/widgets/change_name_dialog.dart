import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../authentication/service/auth_service.dart';
import '../../constants/app_constants.dart';

changeName(BuildContext context){
  return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title:const Text('Change Your Name'),
          content: TextField(
            onChanged: (displayName) {
              displayName=userNameController.text;
            },
            controller:userNameController,
            decoration:const InputDecoration(hintText: "Name..."),
          ),
          actions: [
            ElevatedButton(
                onPressed: (){
                  Provider.of<AuthService>(context,listen: false).updateName();
                  Navigator.pop(context);
                },
                child: Text('SAVE'))
          ],
        );
      });
}