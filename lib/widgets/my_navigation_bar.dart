import 'package:flutter/material.dart';
import 'package:rice_music_sharing/themes/tunedin_icon_icons.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
        //selectedIconTheme: const IconThemeData(color: Colors.white),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.background,
        showSelectedLabels: true,
        fixedColor: Theme.of(context).colorScheme.onBackground,
        currentIndex: 0,
        onTap: (index) => {},
        elevation: 5);
  }
}
