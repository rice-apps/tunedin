import 'package:flutter/material.dart';

class TabBars extends StatelessWidget {
  TabBars({Key? key, required this.tabController}) : super(key: key);

  late TabController tabController;

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
        tabs: const [
          Tab(
            icon: Icon(
              Icons.music_note,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.history,
            ),
          ),
        ],
      ),
    );
  }
}
