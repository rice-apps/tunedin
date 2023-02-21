import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/outlined_button.dart';
import '../widgets/playlist_card.dart';
import '../widgets/profile_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TunedInOutlinedButton(
                    text: "Follow",
                    onPressed: () => {},
                    toggle: false,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  TunedInOutlinedButton(
                    text: "Join",
                    onPressed: () => {},
                    toggle: true,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const FollowCounts(followers: 200),
              const SizedBox(height: 10),
              TabBars(tabController: _tabController, isPersonal: false),
              const SizedBox(height: 25),
              <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Label(name: "1 day ago", count: "3"),
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
        ),
      ]),
    );
  }
}
