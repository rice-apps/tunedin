import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rice_music_sharing/screen/home_screen.dart';
import 'package:rice_music_sharing/screen/login_screen_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../constants.dart';

var casServiceUrl = dotenv.get('CAS_SERVICE_URL');

var casLoginURL =
    'https://idp.rice.edu/idp/profile/cas/login?service=$casServiceUrl/';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void checkSignInStatus(AsyncValue<void> state) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getString(keyUsername) != null) {
        // nav to homepage
        Future.delayed(Duration.zero, () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false);
        });
      } else {
        // initiate onboarding flow -- for now just show home page :)
        Future.delayed(Duration.zero, () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false);
        });
      }
    }

    // listen and rebuild when the state changes
    ref.listen<AsyncValue>(
        loginScreenControllerProvider, (_, state) => checkSignInStatus(state));

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Center(child: TunedInLogo()),
              Center(child: LoginButton())
            ]));
  }
}

class LoginButton extends ConsumerStatefulWidget {
  const LoginButton({super.key});

  @override
  LoginButtonState createState() => LoginButtonState();
}

class LoginButtonState extends ConsumerState<LoginButton> {
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // watch and rebuild when the state changes
    final AsyncValue<void> state = ref.watch(loginScreenControllerProvider);

    void attemptLogin() async {
      // Display login page in WebView
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(casLoginURL)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                      ),
                    ),
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      final uri = navigationAction.request.url!;
                      if (uri.toString().contains('ticket')) {
                        var ticket = uri.toString().split('ticket=').last;
                        ref
                            .read(loginScreenControllerProvider.notifier)
                            .signIn(ticket: ticket);
                        return NavigationActionPolicy.CANCEL;
                      } else {
                        // error handle -- display error page
                        return NavigationActionPolicy.ALLOW;
                      }
                    },
                  )));
    }

    return OutlinedButton(
        onPressed: () => attemptLogin(),
        style: OutlinedButton.styleFrom(
          backgroundColor: isPressed ? const Color(0xFFE197FA) : null,
          shape: const StadiumBorder(),
          fixedSize: const Size(318, 60),
          side: const BorderSide(color: Color(0xFFE197FA), width: 2),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text("Log in with Rice NetID",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: isPressed
                      ? Theme.of(context).colorScheme.background
                      : null)),
          const SizedBox(width: 60),
          Icon(Icons.chevron_right,
              size: 40,
              color: isPressed
                  ? Theme.of(context).colorScheme.background
                  : Colors.white)
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
