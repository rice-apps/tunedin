import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(0),
            child: CustomScrollView(slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 85, 20, 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://picsum.photos/250?image=9",
                      ),
                      radius: 45,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Will Rice College",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: const [
                            Text("208"),
                            Text("Followers"),
                          ],
                        ),
                        Column(
                          children: const [
                            Text("80"),
                            Text("Following"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: OutlinedButton(
                                    onPressed: () => {},
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        minimumSize: const Size(100, 45)),
                                    child: const Text("Follow"))),
                            const SizedBox(
                              width: 25,
                            ),
                            Expanded(
                                child: OutlinedButton(
                                    onPressed: () => {},
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        minimumSize: const Size(100, 45)),
                                    child: const Text("Join"))),
                          ],
                        )),
                    const SizedBox(height: 25),
                    const Text(
                      "Playlists: 4",
                      textAlign: TextAlign.left,
                    ),
                    const PlaylistCard(),
                    const PlaylistCard(),
                    const PlaylistCard(),
                    const PlaylistCard(),
                    const SizedBox(height: 25),
                    Row(children: const [
                      Text(
                        "Browse all playlists 20",
                      ),
                      Spacer(),
                      Icon(Icons.chevron_right),
                    ])
                  ]),
                ),
              )
            ])));
  }
}

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Playlist Name",
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("20 Songs", textAlign: TextAlign.left),
                ],
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Icon(Icons.chevron_right),
              ),
            ],
          )),
    );
  }
}
