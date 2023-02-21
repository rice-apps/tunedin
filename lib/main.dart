import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screen/discovery_screen.dart';
import 'screen/home_screen.dart';
import 'screen/personal_account_screen.dart';
import 'themes/themes.dart';
import 'themes/tunedin_icon_icons.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State {
  int _selectedIndex = 0;

  static const _pages = <Widget>[
    HomeScreen(),
    DiscoveryScreen(),
    PersonalAccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.darkTheme,
      title: 'Welcome to TunedIn',
      home: Scaffold(
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
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            elevation: 5),
        appBar: AppBar(
          title: const Text('Welcome to TunedIn'),
        ),
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
