import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/my_navigation_bar.dart';
import '../widgets/outlined_button.dart';
import '../widgets/single_comment.dart';

class CommentsScreen extends StatefulWidget {
  @override
  State<CommentsScreen> createState() =>
      _CommentWidgetState("I haven't listened to this song in ages", 0, true);
}

class _CommentWidgetState extends State<CommentsScreen> {
  _CommentWidgetState(this.comment, this.numLikes, this.isNotLiked);

  String comment;
  int numLikes;
  bool isNotLiked; // if you liked this comment already
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       bottomNavigationBar: const MyNavigationBar(),
  //       backgroundColor: Theme.of(context).colorScheme.background,
  //       body: Stack());
  // }

  void _onLikeTapped() {
    setState(() {
      numLikes = isNotLiked ? numLikes + 1 : numLikes - 1;
      isNotLiked = !isNotLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const MyNavigationBar(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage:
                  NetworkImage("https://picsum.photos/250?image=9"),
              radius: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text("David"),
                    SizedBox(
                      width: 5,
                    ),
                    Text("32 min ago"),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  comment,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Stack(
                        children: [
                          Icon(Icons.favorite,
                              color:
                                  isNotLiked ? Colors.transparent : Colors.red),
                          Icon(Icons.favorite_border,
                              color: isNotLiked ? Colors.black : Colors.red),
                        ],
                      ),
                      onPressed: () {
                        _onLikeTapped();
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(numLikes.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: const Text("Reply"),
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
