import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  @override
  State<CommentWidget> createState() => _CommentWidgetState();
  const CommentWidget({super.key});
}

class _CommentWidgetState extends State<CommentWidget> {
  int _likes = 0;
  bool _isNotLiked = false;

  void _onLikeTapped() {
    setState(() {
      if (_isNotLiked) {
        _likes = _likes + 1;
      } else {
        _likes = _likes - 1;
      }
      _isNotLiked = !_isNotLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage("https://picsum.photos/250?image=9"),
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
            const Text(
              "I haven't listened to this song in ages.",
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
                          color: _isNotLiked ? Colors.transparent : Colors.red),
                      Icon(Icons.favorite_border,
                          color: _isNotLiked ? Colors.black : Colors.red),
                    ],
                  ),
                  onPressed: () {
                    _onLikeTapped();
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(_likes.toString()),
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
    );
  }
}
