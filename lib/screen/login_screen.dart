import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rice_music_sharing/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// sharedpreferences keys
const keyToken = 'token';
const keyUsername = 'username';

String backendUrl = Platform.isAndroid
    ? dotenv.get('BACKEND_URL')
    : dotenv.get('BACKEND_URL_ANDROID');

var casServiceUrl = dotenv.get('CAS_SERVICE_URL');

var casLoginURL =
    'https://idp.rice.edu/idp/profile/cas/login?service=$casServiceUrl/';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isPressed = false;

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
                    // error handle -- display error page
                  }
                })));
  }

  void _authenticateTicket(String ticket) async {
    final response = await http.get(
      Uri.parse('$backendUrl/auth'),
      headers: {'ticket': ticket},
    );
    final result = json.decode(response.body);

    if (result != null && result['success']) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      // save this user's token and netid
      sharedPreferences.setString(keyToken, result['user']['token']);

      if (result['username'] != null) {
        sharedPreferences.setString(keyUsername, result['user']['username']);

        // nav to homepage
        Future.delayed(Duration.zero, () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false);
        });
      } else {
        // initiate onboarding flow
      }
    } else {
      // error handle -- display error page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Center(child: TunedInLogo()),
              Center(
                  child: OutlinedButton(
                      onPressed: () {
                        setState(() => isPressed = true);
                        _attemptLogin();
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            isPressed ? const Color(0xFFE197FA) : null,
                        shape: const StadiumBorder(),
                        fixedSize: const Size(318, 60),
                        side: const BorderSide(
                            color: Color(0xFFE197FA), width: 2),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text("Log in with Rice NetID",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    color: isPressed
                                        ? Theme.of(context)
                                            .colorScheme
                                            .background
                                        : null)),
                        const SizedBox(width: 60),
                        Icon(Icons.chevron_right,
                            size: 40,
                            color: isPressed
                                ? Theme.of(context).colorScheme.background
                                : Colors.white)
                      ])))
            ]));
  }
}

class TunedInLogo extends StatelessWidget {
  const TunedInLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset('assets/TunedInSplashLogo.svg'),
        Padding(
            padding: const EdgeInsets.fromLTRB(130, 10, 0, 0),
            child: SvgPicture.asset('assets/Beats.svg'))
      ],
    );
  }
}
