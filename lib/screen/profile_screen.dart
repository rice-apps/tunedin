import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage(
            "https://picsum.photos/250?image=9",
          ),
          radius: 75,
        ),
        const Text("Will Rice College"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text("208"),
                const Text("Followers"),
              ],
            ),
            Column(
              children: [
                const Text("80"),
                const Text("Following"),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () => {},
              child: const Text("Follow"),
            ),
            OutlinedButton(
              onPressed: () => {},
              child: const Text("Join"),
            ),
          ],
        ),
        Column(
          children: [
            const Text("Playlists: 4"),
            PlaylistCard(),
          ],
        )
      ],
    ));
  }
}

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "https://picsum.photos/250?image=9",
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          ),
          Column(
            children: [
              const Text("Playlist Name"),
              const Text("Playlist Description"),
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
