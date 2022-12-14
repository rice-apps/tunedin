import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children:[
            SvgPicture.asset('Gradient.svg',
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            SvgPicture.asset('Vector.svg',
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            CustomScrollView(slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 85, 20, 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  CircleAvatar(
                    foregroundImage: NetworkImage(
                      "https://picsum.photos/250?image=9",
                    ),
                    radius: 45,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.tertiary,
                            blurRadius: 25,
                          ),
                        ],
                      ),
                    ),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OutlinedButton(
                              onPressed: () => {},
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                                fixedSize: const Size(100, 36),
                                side: BorderSide(
                                    color: Colors.white,
                                ),
                              ),
                              child: Text("Follow",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium)),
                          const SizedBox(
                            width: 25,
                          ),
                          OutlinedButton(
                              onPressed: () => {},
                              style: OutlinedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                fixedSize: const Size(100, 36),
                                side: BorderSide(
                                    color: Colors.white,
                                ),
                              ),
                              child: Text("Join",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium)),
                        ],
                      )),
                  const SizedBox(height: 25),
                  Text(
                    "Playlists: 4",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineMedium,
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
          ]),
            ]));
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
