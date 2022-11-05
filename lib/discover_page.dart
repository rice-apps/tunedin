import 'package:flutter/material.dart';
//import 'package:material_floating_search_bar/material_floating_search_bar.dart';
//import 'package:sliver_tools/sliver_tools.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // ignore: non_constant_identifier_names
  Widget Tabs() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.flight)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
          title: const Text('Tabs Demo'),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.flight, size: 350),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget HorizontalList(String title) {
    return Container(
        height: 140,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            ListView.builder(
                shrinkWrap: false,
                physics: const ScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    color: Colors.amber[0],
                    child: Center(child: Text('Entry $index')),
                  );
                }),
          ],
        ));
  }

  // children: <Widget>[
  //   Container(
  //     width: 160.0,
  //     color: Colors.red,
  //   ),
  //   Container(
  //     width: 160.0,
  //     color: Colors.blue,
  //   ),
  //   Container(
  //     width: 160.0,
  //     color: Colors.green,
  //   ),
  //   Container(
  //     width: 160.0,
  //     color: Colors.yellow,
  //   ),
  //   Container(
  //     width: 160.0,
  //     color: Colors.orange,
  //   ),
  // ],
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to TunedIn'),
          ),
          resizeToAvoidBottomInset: false,
          body: SizedBox(
              child: Stack(
            fit: StackFit.expand,
            children: [
              //Tabs(),
              //buildFloatingSearchBar(),
              HorizontalList("This is a Horizontal List"),
            ],
          ))),
    );
  }
}
// Widget createAppBar(String message) {
//   return AppBar(
//     backgroundColor: Colors.transparent,
//     elevation: 0.0,
//     title: Text(message),
//     actions: const [
//       Padding(
//           padding: EdgeInsets.only(right: 10), child: Icon(Icons.settings))
//     ],
//   );
// }

// @override
// Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           title: const Text(
//             'SliverPersistentHeader Sample',
//             style: TextStyle(
//               fontFamily: 'Allison',
//               fontSize: 60,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//       ),
//     ])
// }
// return Scaffold(

//   body: CustomScrollView(
//     slivers: [
//       SliverPinnedHeader(
//         child: Container(
//             color: Colors.blue[100],
//             height: 100,
//             child: Text("This is a header.")),
//       ),
//       SliverList(
//           delegate: SliverChildBuilderDelegate(
//         (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Container(
//               color: index % 2 == 0 ? Colors.green : Colors.greenAccent,
//               height: 40,
//               alignment: Alignment.center,
//               child: Text(
//                 "Item $index",
//                 style: const TextStyle(fontSize: 30),
//               ),
//             ),
//           );
//         },
//         // 40 list items
//         childCount: 40,
//       )),
//     ],
//   ),
// );

// return MaterialApp(
//     home: MultiSliver(
//   // defaults to false
//     pushPinnedChildren: true,
//     children: <Widget>[
//     SliverPinnedHeader(
//         child: Container(
//             color: Colors.yellow,
//             height: 100,
//             child: Text(
//               "I am a Pinned Header",
//               style: TextStyle(fontSize: 30),
//             ))),
//     SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               color: index % 2 == 0 ? Colors.green : Colors.greenAccent,
//               height: 80,
//               alignment: Alignment.center,
//               child: Text(
//                 "Item $index",
//                 style: const TextStyle(fontSize: 30),
//               ),
//             ),
//           );
//         },
//         // 40 list items
//         childCount: 40,
//       ),
//     ),
//   ],
// )

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     // This is handled by the search bar itself.
//     resizeToAvoidBottomInset: false,
//     body: Stack(
//       fit: StackFit.expand,
//       children: [
//         buildFloatingSearchBar(context),
//       ],
//     ),
//   );
// }

// Widget Tabs() {
//   return DefaultTabController(
//     length: 3,
//     child: Scaffold(
//       appBar: AppBar(
//         bottom: const TabBar(
//           tabs: [
//             Tab(icon: Icon(Icons.flight)),
//             Tab(icon: Icon(Icons.directions_transit)),
//             Tab(icon: Icon(Icons.directions_car)),
//           ],
//         ),
//         title: const Text('Tabs Demo'),
//       ),
//       body: const TabBarView(
//         children: [
//           Icon(Icons.flight, size: 350),
//           Icon(Icons.directions_transit, size: 350),
//           Icon(Icons.directions_car, size: 350),
//         ],
//       ),
//     ),
//   );
// }

// Widget HorizontalList(String title) {
//   return ListView(
//     scrollDirection: Axis.horizontal,
//     children: <Widget>[
//         Text(title),
//         ListView.builder(
//           shrinkWrap: false,
//           physics: ScrollPhysics(),
//           itemBuilder:
//           ((context, index) {
//               return ElevatedButton(
//                 onPressed: () {},
//                 child: const Text("Test")
//               );
//             })
//         )
//     ],
//   );
// }

// Widget buildFloatingSearchBar() {
//   // final isPortrait =
//   // MediaQuery.of(context).orientation == Orientation.portrait;

//   return FloatingSearchBar(
//     hint: 'Search Music',
//     scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
//     transitionDuration: const Duration(milliseconds: 800),
//     transitionCurve: Curves.easeInOut,
//     physics: const BouncingScrollPhysics(),
//     axisAlignment: 0.0,
//     openAxisAlignment: 0.0,
//     width: 600,
//     debounceDelay: const Duration(milliseconds: 500),
//     borderRadius: BorderRadius.circular(5),
//     onQueryChanged: (query) {
//       // Call your model, bloc, controller here.
//     },
//     // Specify a custom transition to be used for
//     // animating between opened and closed stated.
//     transition: CircularFloatingSearchBarTransition(),
//     // actions: [
//     //   FloatingSearchBarAction(
//     //     showIfOpened: false,
//     //     child: CircularButton(
//     //       icon: const Icon(Icons.music_note),
//     //       onPressed: () {},
//     //     ),
//     //   ),
//     //   FloatingSearchBarAction.searchToClear(
//     //     showIfClosed: false,
//     //   ),
//     // ],
//     builder: (context, transition) {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(30),
//         child: Material(
//           color: Colors.white,
//           elevation: 4.0,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: Colors.accents.map((color) {
//               return Container(height: 112, color: color);
//             }).toList(),
//           ),
//         ),
//       );
//     },
//   );
// }
