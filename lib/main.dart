import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rice_music_sharing/data/repositories/storage_repository.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';
import 'themes/themes.dart';
import '../constants.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> get loggedIn async {
    final StorageRepository storageRepo = StorageRepository();
    return storageRepo.containsKeyInSecureData(keyToken);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.darkTheme,
      title: 'Welcome to TunedIn',
      home: Scaffold(
          body: FutureBuilder(
        future: loggedIn,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();
          if (snapshot.data == true) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      )),
    );
  }
}
