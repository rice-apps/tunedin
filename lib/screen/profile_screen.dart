import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 25,
          ),
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
                                  borderRadius: BorderRadius.circular(8)),
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
                                  borderRadius: BorderRadius.circular(8)),
                              minimumSize: const Size(100, 45)),
                          child: const Text("Join"))),
                ],
              )),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                icon: Icon(Icons.music_note,
                color: Colors.black,),
              ),
              Tab(
                icon: Icon(Icons.history,
                color: Colors.black,),
              ),
            ],
          ),
          const SizedBox(height: 25),
          <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "1 day ago",
                  textAlign: TextAlign.left,
                ),
                InfoCard(),
                InfoCard(),
                InfoCard(),
                InfoCard(),
                SizedBox(height: 25),
              ],
            ),
          ][_tabController.index],
        ]),
      ),
    ));
  }
}

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {},
          child: const InfoCard(
            hasChevron: true,
          )),
    );
  }
}

class InfoCard extends StatelessWidget {
  final bool hasChevron;
  const InfoCard({this.hasChevron = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
        if (hasChevron) const Spacer(),
        if (hasChevron)
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Icon(Icons.chevron_right),
          ),
      ],
    );
  }
}
