import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rice_music_sharing/widgets/profile_widgets.dart';
import '../widgets/outlined_button.dart';
import '../widgets/playlist_card.dart';

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
              const ProfileHeader(),
              TunedInOutlinedButton(
                text: "Edit Profile",
                onPressed: () => {},
                toggle: false,
              ),
              const SizedBox(height: 10),
              const FollowCounts(followers: 200, following: 200),
              const SizedBox(height: 10),
              TabBars(
                tabController: _tabController,
                isPersonal: true,
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
