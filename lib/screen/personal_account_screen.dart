import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/my_navigation_bar.dart';
import '../widgets/outlined_button.dart';
import '../widgets/playlist_card.dart';
import '../widgets/tab_bar.dart';

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
      // bottomNavigationBar: const MyNavigationBar(),
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
              TabBars(tabController: _tabController,),
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
