import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({Key? key}) : super(key: key);

  @override
  _DiscoveryScreenState createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> with TickerProviderStateMixin{
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
              title: Text('Explore', textAlign: TextAlign.left,),
              background: Image.network(
                  "https://images.unsplash.com/photo-1603785608232-44c43cdc0d70",
                  fit: BoxFit.cover),
            ),
        ),
        //SliverPersistentHeader(pinned: true, floating: false, delegate: Delegate()),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
              height: 36,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Color(0xFF303449),
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
                  color: Color(0xFF8E909E),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                //indicatorColor: Color(0xFF8E909E),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                tabs: [
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
        ),
        SliverList(delegate:
          SliverChildBuilderDelegate(((context, index) => 
            Padding(padding: EdgeInsets.fromLTRB(0, 48, 0, 0),child: SongRow())
          ), childCount: 100)
        ),

      ],
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: Center(
        child: FloatingSearchBar(
          hint: 'Search Musics',
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    openAxisAlignment: 0.0,
    width: 1000,
    debounceDelay: const Duration(milliseconds: 500),
    onQueryChanged: (query) {
      // Call your model, bloc, controller here.
    },
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    transition: CircularFloatingSearchBarTransition(),
    actions: [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.place),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ],
          builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Colors.accents.map((color) {
              return Container(height: 112, color: color);
            }).toList(),
          ),
        ),
      );
    },
        ),
        ),
      );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 50;

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
        children: [
          Text("Category Name"),
          Spacer(),
          Text("See All"),
        ],
      ),
      
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 8,
        children: const[
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
        ]
      ))
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