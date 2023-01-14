import 'package:flutter/material.dart';

class CreatePostWidget extends StatefulWidget {
  const CreatePostWidget({Key? key}) : super(key: key);

  static Route get route =>
      MaterialPageRoute(builder: (_) => const CreatePostWidget());

  @override
  _CreatePostState createState() => _CreatePostState();
}

// bottom sheet to create pop up

class _CreatePostState extends State<CreatePostWidget> {
  @override
  Widget build(BuildContext context) {
    const maxLines = 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Align(
          alignment: Alignment.center,
          child: Text("Create your post", style: TextStyle(fontSize: 16),),
        ),
        
        Image.network('https://i.scdn.co/image/ab67616d0000b273937af329667311f4b2831616', width: 100, height: 100,),
        // center aligned 
        // Align(
        //   alignment: Alignment.center,
        //   child: Image.asset("images/songimg.jpeg", height: 75, width: 75,),
        // ), 
        
        const Align(
          alignment: Alignment.center,
          child: Text("Last Friday Night", style: TextStyle(fontSize: 12),), 
        ),
        const Align(
          alignment: Alignment.center,
          child: Text("Katy Perry", style: TextStyle(fontSize: 12),),
        ),
        
        const TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Share your thoughts...',
          ),
        ),
        
        OutlinedButton(
          onPressed: () {
            debugPrint('Received click');
          },
          child: const Text('Post'),
        ),

        // const Align(
        //   alignment: Alignment.center,
        //   child: OutlinedButton(
        //   onPressed: () { debugPrint('Received click'); },
        // child: const Text('Post'),
        // ),
        // ),
      ],
    );
  }
}
