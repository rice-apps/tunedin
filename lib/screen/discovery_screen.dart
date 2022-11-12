import 'package:flutter/material.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({Key? key}) : super(key: key);

  @override
  _DiscoveryScreenState createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                  ((context, index) => const Padding(
                      padding: EdgeInsets.fromLTRB(0, 48, 0, 0),
                      child: SongRow())),
                  childCount: 100)),
        )
      ],
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: const Center(
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
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
    return Column(children: [
      Row(
        children: const [
          Text("Category Name"),
          Spacer(),
          Text("See All"),
        ],
      ),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(spacing: 8, children: const [
            FollowWidget(),
            FollowWidget(),
            SongWidget(),
            SongWidget(),
            SongWidget(),
            SongWidget(),
            SongWidget(),
            SongWidget(),
            SongWidget(),
            SongWidget(),
            SongWidget(),
            SongWidget(),
            SongWidget(),
          ]))
    ]);
  }
}

class SongWidget extends StatelessWidget {
  const SongWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "https://picsum.photos/250?image=9",
              height: 144,
              width: 144,
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            "Playlist Name",
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text("20 Songs", textAlign: TextAlign.left),
        ],
      ),
    );
  }
}

class FollowWidget extends StatefulWidget {
  const FollowWidget({Key? key}) : super(key: key);

  @override
  _FollowWidgetState createState() => _FollowWidgetState();
}

class _FollowWidgetState extends State<FollowWidget> {
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
        height: 180,
        width: 138,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(
            4.0,
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
                    const SizedBox(height: 10,),
                    const Text("User Name", style: TextStyle(color: Colors.white),),
                    const SizedBox(height: 10,),
                    OutlinedButton(
                      onPressed: ()=>{},
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.white),
                        minimumSize: const Size(100, 40)
                      ), 
                      child: const Text("Follow", style: TextStyle(color: Colors.white),)
                    )
          ],)
        ),
      ),
    );
  }
}