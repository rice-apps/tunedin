import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostSongDetails extends StatelessWidget {
  const PostSongDetails({super.key});
  // add SongModel as input
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            "https://upload.wikimedia.org/wikipedia/en/2/2b/Katy_Perry_-_One_of_the_Boys.png",
            width: 184,
            height: 184,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          "Teenage Dream",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 5),
        Text("Katy Perry",
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
              onPressed: () async {
                const spotifyUrl =
                    'https://open.spotify.com/track/6AOdKVvWB8Ulb3lGCnyPBY?si=56a9bd1fe20743ba';
                final Uri url = Uri.parse(spotifyUrl);
                if (await canLaunchUrl(url)) {
                  launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  Fluttertoast.showToast(
                      msg: "Could not open Spotify link.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
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
        color: Theme.of(context).colorScheme.secondary,
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
