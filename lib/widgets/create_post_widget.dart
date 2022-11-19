import 'package:flutter/material.dart';

class CreatePostWidget extends StatefulWidget {
  const CreatePostWidget({Key? key}) : super(key: key);

  static Route get route =>
      MaterialPageRoute(builder: (_) => const CreatePostWidget());

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePostWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      
    ],)
  }
}