import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rice_music_sharing/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;

const keyToken = 'token';
const keyNetID = 'netid';
const casLoginURL =
    'https://idp.rice.edu/idp/profile/cas/login?service=localhost:3000/auth';
final Uri _url = Uri.parse(casLoginURL);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String? _ticket;
  html.WindowBase? _popupWin;

  Future<bool> _authenticateTicket(String data) async {
    // Parse data to extract the ticket.
    final receivedUri = Uri.parse(data);

    // Close the popup window
    if (_popupWin != null) {
      _popupWin!.close();
    }

    setState(() => _ticket = receivedUri.fragment
        .split('?')
        .firstWhere((e) => e.startsWith('ticket='))
        .substring('ticket='.length));

    final response = await http.get(
      Uri.parse('localhost:3000/auth'),
      headers: {'ticket': '$_ticket'},
    );
    final result = json.decode(response.body);

    if (!result['success']) {
      print(result['message']);
    }

    if (result && result['success']) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(keyToken, result['user']['token']);
      sharedPreferences.setString(keyNetID, result['user']['netid']);

      return true;
    } else {
      return false;
    }
  }

  void _attemptLogin() {
    // Listen to message send with `postMessage`.
    html.window.onMessage.listen((event) {
      // The event contains the ticket which means the user has logged in
      if (event.data.toString().contains('ticket=')) {
        Future.delayed(Duration.zero, () {
          _authenticateTicket(event.data).then((val) {
            if (val) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const HomeScreen()));
            } else {
              // ADD ERROR
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const HomeScreen()));
            }
          });
        });
      }
    });

    // Open the Rice CAS login page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUri = Uri.base;
      final redirectUri = Uri(
        host: currentUri.host,
        scheme: currentUri.scheme,
        port: currentUri.port,
        path: '/redirect.html',
      );
      final authUrl =
          'https://idp.rice.edu/idp/profile/cas/login?service=$redirectUri';
      _popupWin = html.window.open(
          authUrl, "Rice NetID Login", "width=800, height=900, scrollbars=yes");
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TunedIn Log In"),
      ),
      body:
          ElevatedButton(onPressed: _attemptLogin, child: const Text('Log In')),
    );
  }
}
