import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/my_navigation_bar.dart';
import '../widgets/outlined_button.dart';

class PersonalAccountScreen extends StatefulWidget {
  const PersonalAccountScreen({Key? key}) : super(key: key);

  @override
  State<PersonalAccountScreen> createState() => _PersonalAccountScreen();
}

class _PersonalAccountScreen extends State<PersonalAccountScreen>
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
      bottomNavigationBar: const MyNavigationBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(children: [
        SvgPicture.asset(
          'Gradient.svg',
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
        ),
        SvgPicture.asset(
          'Vector.svg',
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 85, 20, 20),
            child: Column(children: [
              CircleAvatar(
                foregroundImage: const NetworkImage(
                  "https://picsum.photos/250?image=9",
                ),
                radius: 45,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.tertiary,
                        blurRadius: 40,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Olivia Malone",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 25,
              ),
              TunedInOutlinedButton(
                text: "Edit Profile",
                onPressed: () => {},
                toggle: false,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("208",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                              )),
                      Text("Followers",
                          style: Theme.of(context).textTheme.displaySmall),
                    ],
                  ),
                  Column(
                    children: [
                      Text("80",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      Text("Following",
                          style: Theme.of(context).textTheme.displaySmall),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF404663),
                      width: 2,
                    ),
                  ),
                ),
                child: TabBar(
                  indicatorColor: Theme.of(context).colorScheme.onBackground,
                  labelColor: Theme.of(context).colorScheme.onBackground,
                  unselectedLabelColor: const Color(0xFF404663),
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      icon: Icon(
                        Icons.music_note,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.history,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Label(name: "Songs", count: "120"),
                    PlaylistCard(),
                    SizedBox(height: 25),
                    Label(name: "Playlists", count: "8"),
                    PlaylistCard(),
                    PlaylistCard(),
                    PlaylistCard(),
                    PlaylistCard(),
                    PlaylistCard(),
                    PlaylistCard(),
                    PlaylistCard(),
                    PlaylistCard(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Label(name: "1 day ago", count: "3"),
                    InfoCard(),
                    InfoCard(),
                    InfoCard(),
                    SizedBox(height: 25),
                    Label(name: "1 week ago", count: "4"),
                    InfoCard(),
                    InfoCard(),
                    InfoCard(),
                    InfoCard(),
                  ],
                ),
              ][_tabController.index],
            ]),
          ),
        ),
      ]),
    );
  }
}

class Label extends StatelessWidget {
  final String name;
  final String count;

  const Label({Key? key, required this.name, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
      child: RichText(
          text: TextSpan(
        text: '$name ',
        style: Theme.of(context).textTheme.headlineMedium,
        children: [
          const WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: SizedBox(width: 5)),
          TextSpan(
            text: count,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFFA1A9BC),
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      )),
    );
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

  const InfoCard({
    Key? key,
    this.hasChevron = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "https://picsum.photos/250?image=9",
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Playlist Name",
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text("20 Songs",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: const Color(0xFFA1A9BC),
                    )),
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
