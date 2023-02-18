import 'package:flutter/material.dart';
import 'package:rice_music_sharing/sheet/share_modal.dart';
import 'package:rice_music_sharing/widgets/my_navigation_bar.dart';

import 'themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.darkTheme,
      title: 'Welcome to TunedIn',
      home: Scaffold(
        bottomNavigationBar: const MyNavigationBar(),
        appBar: AppBar(
          title: const Text('Welcome to TunedIn'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<dynamic>(
                  isScrollControlled: true,
                  context: context,
                  builder: (sheetContext) => MediaQuery(
                      data: MediaQueryData.fromWindow(
                          WidgetsBinding.instance.window),
                      child: SafeArea(child: ShareModal())));
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.blue,
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }
}
