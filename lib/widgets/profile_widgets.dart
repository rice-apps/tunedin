import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          "Will Rice College",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}

class TabBars extends StatelessWidget {
  const TabBars(
      {Key? key, required this.tabController, required this.isPersonal})
      : super(key: key);

  final TabController tabController;
  // whether these tab bars are for a personal profile or an external profile
  final bool isPersonal;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
        controller: tabController,
        tabs: [
          const Tab(
            icon: Icon(
              Icons.history,
            ),
          ),
          if (isPersonal)
            const Tab(
              icon: Icon(
                Icons.bookmark_border,
              ),
            ),
        ],
      ),
    );
  }
}

class FollowCounts extends StatelessWidget {
  const FollowCounts({super.key, required this.followers, this.following});

  final int followers;
  final int? following;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(followers.toString(),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    )),
            Text("Followers", style: Theme.of(context).textTheme.displaySmall),
          ],
        ),
        if (following != null)
          Column(
            children: [
              Text(following.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.w600)),
              Text("Following",
                  style: Theme.of(context).textTheme.displaySmall),
            ],
          )
      ],
    );
  }
}
