import 'package:flutter/material.dart';

class NoteView extends StatelessWidget {
  const NoteView({
    required this.data,
    Key? key,
  }) : super(key: key);

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:Text('${data['title']}'),
      subtitle:Text('${data['description']}'),
    );
  }
}