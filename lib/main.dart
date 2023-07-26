import 'package:flutter/material.dart';
import 'package:rice_music_sharing/sheet/share_modal.dart';

import 'themes/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rice_music_sharing/data/repositories/storage_repository.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';
import '../constants.dart';
import 'screen/discovery_screen.dart';
import 'screen/profile_screen.dart';
import 'screen/personal_account_screen.dart';
import 'themes/tunedin_icon_icons.dart';

void main() async {
  runApp(
    ProviderScope(
      child: MaterialApp(
          theme: Themes.darkTheme,
          title: 'Welcome to TunedIn',
          home: ProfileScreen(isGroupProfile: false)),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> get loggedIn async {
    final StorageRepository storageRepo = StorageRepository();
    storageRepo.deleteAllSecureData();
    return storageRepo.containsKeyInSecureData(keyToken);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.darkTheme,
      title: 'Welcome to TunedIn',
      home: FutureBuilder(
        future: loggedIn,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();
          if (snapshot.data == true) {
            return const TunedIn();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

class TunedIn extends StatefulWidget {
  const TunedIn({super.key});

  @override
  TunedInState createState() => TunedInState();
}

class TunedInState extends State {
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
    return Scaffold(
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: Theme.of(context).colorScheme.outline, width: 1))),
          child: BottomNavigationBar(
            selectedLabelStyle: Theme.of(context).textTheme.labelMedium,
            unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(TunedinIcon.home_unfilled),
                activeIcon: Icon(TunedinIcon.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(TunedinIcon.explore_unfilled),
                activeIcon: Icon(TunedinIcon.explore_filled),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(TunedinIcon.account_unfilled),
                activeIcon: Icon(TunedinIcon.account_filled),
                label: 'Account',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,
            elevation: 5,
          )),
      // appBar: AppBar(
      //   title: const Text('TunedIn'),
      // ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (sheetContext) => MediaQuery(
                    data: MediaQueryData.fromWindow(
                        WidgetsBinding.instance.window),
                    child: const SafeArea(child: ShareModal())));
          },
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          child:
              Icon(Icons.add, color: Theme.of(context).colorScheme.background),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
