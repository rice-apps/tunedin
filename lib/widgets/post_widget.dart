import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage("https://picsum.photos/250?image=9"),
                radius: 15,
              ),
              CircleAvatar(
                backgroundImage:
                    NetworkImage("https://picsum.photos/250?image=9"),
                radius: 15,
              ),
              CircleAvatar(
                backgroundImage:
                    NetworkImage("https://picsum.photos/250?image=9"),
                radius: 15,
              ),
            ],
          ),
          Text(
            "David, Bridget, and 3 others liked this",
          ),
        ],
      ),
      Container(
        child: Row(
          children: [
            ClipRect(
              child: Image.network(
                "https://picsum.photos/250?image=9",
                width: 120,
                height: 120,
                fit: BoxFit.fill,
              )
            ),
          ],
        ),
      )
    ]);
  }
}
