import 'package:flutter/material.dart';
import 'widgets/my_navigation_bar.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

// Auth0 Variables

const AUTH0_DOMAIN = 'dev-kt5qj3uqxps4pfhg.us.auth0.com';
const AUTH0_CLIENT_ID = 'BHLNHUjsA4IQbAWL7WlX6ccJtVVJCojR';

const AUTH0_REDIRECT_URI = 'com.example.tunedin://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to TunedIn',
      home: Scaffold(
        bottomNavigationBar: const MyNavigationBar(),
        appBar: AppBar(
          title: const Text('Welcome to TunedIn'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
