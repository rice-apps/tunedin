import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';
import 'themes/themes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// SharedPreferences keys
const keyToken = 'token';
const keyUsername = 'username';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> get loggedIn async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(keyToken);
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
