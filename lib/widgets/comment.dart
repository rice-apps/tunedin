import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  final bool children;

  @override
  State<Comment> createState() => _CommentState();
  const Comment({super.key, this.children = false});
}

class _CommentState extends State<Comment> {
  int _likes = 0;
  bool _isNotLiked = true;

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
              children: [
                Text(
                  "David",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "32 min ago",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: const Color(0xFF878D9E),
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "I haven't listened to this song in ages.",
              style: Theme.of(context).textTheme.displayMedium,
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
                          color: _isNotLiked
                              ? Colors.transparent
                              : const Color(0xFFFF417F)),
                      Icon(Icons.favorite_border,
                          color: _isNotLiked
                              ? const Color(0xFF878D9E)
                              : const Color(0xFFFF417F)),
                    ],
                  ),
                  onPressed: () {
                    _onLikeTapped();
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  _likes.toString(),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: const Color(0xFF878D9E),
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF878D9E),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Reply",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF878D9E),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
            if (widget.children)
              Column(
                children: const [
                  Padding(padding: EdgeInsets.only(top: 15), child: Comment()),
                ],
              ),
            Row(children: [
              CustomPaint(painter: LinePaint()),
              const SizedBox(
                width: 30,
              ),
              Text(
                "View 3 more replies",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: const Color(0xFF878D9E),
                      fontWeight: FontWeight.w600,
                    ),
              )
            ])
          ],
        ),
      ],
    );
  }
}

class LinePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF303449)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawLine(const Offset(0, 0), const Offset(20, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
