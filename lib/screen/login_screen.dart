import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rice_music_sharing/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// sharedpreferences keys
const keyToken = 'token';
const keyNetID = 'netid';

var casServiceUrl = dotenv.get('CAS_SERVICE_URL');
var casServiceUrlAndroid = dotenv.get('CAS_SERVICE_URL_ANDROID');

String authRequestUrl =
    Platform.isAndroid ? casServiceUrlAndroid : casServiceUrl;

var casLoginURL =
    'https://idp.rice.edu/idp/profile/cas/login?service=$casServiceUrl/';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _attemptLogin() async {
    // Display login page in WebView
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(casLoginURL)),
                onUpdateVisitedHistory: (_, Uri? uri, __) {
                  if (uri.toString().contains('ticket')) {
                    var ticket = uri.toString().split('ticket=').last;
                    _authenticateTicket(ticket);
                  } else {
                    // error handle
                  }
                })));
  }

  void _authenticateTicket(String ticket) async {
    final response = await http.get(
      Uri.parse('$authRequestUrl/auth'),
      headers: {'ticket': ticket},
    );
    final result = json.decode(response.body);

    if (result != null && result['success']) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      // save this user's token and netid
      sharedPreferences.setString(keyToken, result['user']['token']);
      sharedPreferences.setString(keyNetID, result['user']['netid']);

      // nav to homepage
      Future.delayed(Duration.zero, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    } else {
      //error handle
    }
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
