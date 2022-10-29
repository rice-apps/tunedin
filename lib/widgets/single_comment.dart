import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  @override
  _CommentWidgetState createState() => _CommentWidgetState();
  const CommentWidget({super.key});
}

class _CommentWidgetState extends State<CommentWidget> {
  int _likes = 0;
  Color _favIconColor = Color(0x00000000);
  Color _favIconOutline = Colors.black;

  void _onLikeTapped() {
    setState(() {
      if (_favIconColor == Color(0x00000000)) {
        _likes = _likes - 1;
      } else {
        _likes = _likes + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage("https://picsum.photos/250?image=9"),
          radius: 18,
        ),
        SizedBox(
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
            SizedBox(
              height: 5,
            ),
            const Text(
              "I haven't listened to this song in ages.",
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Stack(
                    children: [
                      Icon(Icons.favorite, color: _favIconColor),
                      Icon(Icons.favorite_border, color: _favIconOutline),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      if (_favIconColor == Color(0x00000000)) {
                        _favIconColor = Colors.red;
                        _favIconOutline = Colors.red;
                      } else {
                        _favIconColor = Color(0x00000000);
                        _favIconOutline = Colors.black;
                      }
                    });
                    _onLikeTapped();
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text(_likes.toString()),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Text("Reply"),
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
