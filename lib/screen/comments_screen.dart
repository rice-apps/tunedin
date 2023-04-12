import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/my_navigation_bar.dart';
import '../widgets/outlined_button.dart';
import '../widgets/single_comment.dart';
import '../widgets/SingleComment.dart';

class CommentsScreen extends StatefulWidget {
  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  List<String> _comments = <String>['A', 'B', 'C'];
  List<int> _numLikes = <int>[1, 2, 3];
  List<bool> _liked = <bool>[true, false, true];

  void _onLikeTapped(int index) {
    setState(() {
      _numLikes[index] =
          _liked[index] ? _numLikes[index] + 1 : _numLikes[index] - 1;
      _liked[index] = !_liked[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyNavigationBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView.builder(
        itemCount: _comments.length,
        itemBuilder: (context, index) {
          return SingleComment(
            comment: _comments[index],
            numLikes: _numLikes[index],
            isNotLiked: !_liked[index],
            onLikeTapped: () => _onLikeTapped(index),
          );
        },
      ),
    );
  }
}
