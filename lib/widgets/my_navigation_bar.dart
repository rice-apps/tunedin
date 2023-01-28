import 'package:flutter/material.dart';
import 'package:rice_music_sharing/screen/discovery_screen.dart';
import 'package:rice_music_sharing/screen/home_screen.dart';
import 'package:rice_music_sharing/screen/profile_screen.dart';
import 'package:rice_music_sharing/themes/tunedin_icon_icons.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBar();
}

class _MyNavigationBar extends State<MyNavigationBar> {
  int _selectedIndex = 0;

  static const _pages = <Widget>[
    HomeScreen(),
    DiscoveryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: Theme.of(context).textTheme.labelMedium,
          unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(TunedinIcon.home_unfilled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(TunedinIcon.explore_unfilled),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(TunedinIcon.account_unfilled),
              label: 'Account',
            ),
          ],
          // selectedIconTheme: const IconThemeData(color: Colors.white),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.background,
          showSelectedLabels: true,
          // fixedColor: Theme.of(context).colorScheme.onBackground,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
