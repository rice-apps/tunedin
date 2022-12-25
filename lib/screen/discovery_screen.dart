import 'package:flutter/material.dart';
import 'package:rice_music_sharing/widgets/outlined_button.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({Key? key}) : super(key: key);

  @override
  DiscoveryScreenState createState() => DiscoveryScreenState();
}

class DiscoveryScreenState extends State<DiscoveryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: const Text(
                'Explore',
                textAlign: TextAlign.left,
              ),
              background: Image.network(
                  "https://images.unsplash.com/photo-1603785608232-44c43cdc0d70",
                  fit: BoxFit.cover),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            sliver: SliverPersistentHeader(
                pinned: true, floating: false, delegate: Delegate()),
          ),
          SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  height: 36,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: const Color(0xFF303449),
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                      color: const Color(0xFF8E909E),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    //indicatorColor: Color(0xFF8E909E),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    tabs: const [
                      // first tab [you can add an icon using the icon property]
                      Tab(
                        text: 'Music',
                      ),
                      // second tab [you can add an icon using the icon property]
                      Tab(
                        text: 'Groups',
                      ),
                      Tab(
                        text: 'Users',
                      ),
                    ],
                  ),
                ),
              )),
          [
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    ((context, index) => const Padding(
                        padding: EdgeInsets.fromLTRB(0, 48, 0, 0),
                        child: SongRow())),
                    childCount: 100)),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    ((context, index) => const Padding(
                        padding: EdgeInsets.fromLTRB(0, 48, 0, 0),
                        child: SongRow())),
                    childCount: 100)),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    ((context, index) => const Padding(
                        padding: EdgeInsets.fromLTRB(0, 48, 0, 0),
                        child: UserRow())),
                    childCount: 100)),
          ][_tabController.index],
        ],
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Center(
        child: TextField(
          keyboardType: TextInputType.text,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.black,
              ),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.black,
                ),
            prefixIcon: Icon(Icons.search, color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(color: Color(0xFF303449), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(color: Color(0xFF303449), width: 1),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class SongRow extends StatelessWidget {
  const SongRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
          child: Text(
            "Category Name",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          )),
      SizedBox(
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(index == 0 ? 16 : 0, 0, 8, 0),
              child: const FollowWidget(),
            );
          },
        ),
      )
    ]);
  }
}

class UserRow extends StatelessWidget {
  const UserRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
        child: Text("Category Name",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
      ),
      SizedBox(
        height: 230,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(index == 0 ? 16 : 0, 0, 8, 0),
              child: const SongWidget(),
            );
          },
        ),
      )
    ]);
  }
}

class SongWidget extends StatelessWidget {
  const SongWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            "https://picsum.photos/250?image=9",
            height: 185,
            width: 185,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text("Playlist Name",
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 5,
        ),
        Text("20 Songs", style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}

class FollowWidget extends StatefulWidget {
  const FollowWidget({Key? key}) : super(key: key);

  @override
  FollowWidgetState createState() => FollowWidgetState();
}

class FollowWidgetState extends State<FollowWidget> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFollowing = !_isFollowing;
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        clipBehavior: Clip.hardEdge,
        width: 160,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
          border: Border.all(
            color: const Color(0xFF303449),
            width: 1,
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://picsum.photos/250?image=9",
              ),
              radius: 45,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "User Name",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            TunedInOutlinedButton(text: "Follow", onPressed: () => {})
          ],
        )),
      ),
    );
  }
}
