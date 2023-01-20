import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';
import 'themes/themes.dart';
import 'widgets/my_navigation_bar.dart';

const keyToken = 'token';
const keyNetID = 'netid';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> get loggedIn async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.get(keyToken);
    return token != null;
  }

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
          body: FutureBuilder(
            future: loggedIn,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
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
