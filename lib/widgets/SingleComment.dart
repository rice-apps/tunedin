import 'package:flutter/material.dart';

class SingleComment extends StatelessWidget {
  final String comment;
  final int numLikes;
  final bool isNotLiked;
  final VoidCallback onLikeTapped;

  const SingleComment({
    Key? key,
    required this.comment,
    required this.numLikes,
    required this.isNotLiked,
    required this.onLikeTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
          radius: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('David'),
                  const SizedBox(width: 5),
                  Text(
                    '32 min ago',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(comment),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Stack(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: isNotLiked ? Colors.transparent : Colors.red,
                        ),
                        Icon(
                          Icons.favorite_border,
                          color: isNotLiked ? Colors.black : Colors.red,
                        ),
                      ],
                    ),
                    onPressed: onLikeTapped,
                  ),
                  const SizedBox(width: 5),
                  Text(numLikes.toString()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
