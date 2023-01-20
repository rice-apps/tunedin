import 'package:flutter/material.dart';

class PostSongDetails extends StatelessWidget {
  const PostSongDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            "https://picsum.photos/250?image=9",
            width: 184,
            height: 184,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          "Song Name",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 5),
        Text("Artist Name",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: const Color(0xFFB7B7B7),
                )),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PostActionButton(
              icon: Icons.play_arrow,
              text: "Listen",
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            PostActionButton(
              icon: Icons.add_box_outlined,
              text: "Share",
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            PostActionButton(
              icon: Icons.bookmark_border,
              text: "Save",
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}

class PostActionButton extends StatelessWidget {
  final IconData icon;

  final void Function() onPressed;

  final String text;

  const PostActionButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: 72,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: InkWell(
          onTap: onPressed,
          splashColor: Theme.of(context).colorScheme.onSurfaceVariant,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 30,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}