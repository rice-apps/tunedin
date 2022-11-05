/// -----------------------------------
///          External Packages
/// -----------------------------------
import 'package:flutter/material.dart';
import 'widgets/my_navigation_bar.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------
const AUTH0_DOMAIN = 'dev-kt5qj3uqxps4pfhg.us.auth0.com';
const AUTH0_CLIENT_ID = 'BHLNHUjsA4IQbAWL7WlX6ccJtVVJCojR';

const AUTH0_REDIRECT_URI = 'com.auth0.tunedin://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

/// -----------------------------------
///           Profile Widget
/// -----------------------------------
class Profile extends StatelessWidget {
  final logoutAction;
  final String name;
  final String picture;

  Profile(this.logoutAction, this.name, this.picture);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4.0),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(picture ?? ''),
            ),
          ),
        ),
        SizedBox(height: 24.0),
        Text('Name: $name'),
        SizedBox(height: 48.0),
        ElevatedButton(
          onPressed: () {
            logoutAction();
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}

/// -----------------------------------
///            Login Widget
/// -----------------------------------
class Login extends StatelessWidget {
  final loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            loginAction();
          },
          child: const Text('Login'),
        ),
        Text(loginError ?? ''),
      ],
    );
  }
}

/// -----------------------------------
///                 App
/// -----------------------------------
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

/// -----------------------------------
///              App State
/// -----------------------------------
class _MyAppState extends State<MyApp> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage = "";
  String name = "";
  String picture = "";

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Welcome to TunedIn',
    //   home: Scaffold(
    //     bottomNavigationBar: const MyNavigationBar(),
    //     appBar: AppBar(
    //       title: Text('Welcome to TunedIn'),
    //     ),
    //     body: Center(
    //       child: isBusy
    //           ? CircularProgressIndicator()
    //           : isLoggedIn
    //               ? Profile(logoutAction, name, picture)
    //               : Login(loginAction, errorMessage),
    //     ),
    //   ),
    // );
    return MaterialApp(
      title: 'Welcome to TunedIn',
      home: Scaffold(
        //bottomNavigationBar: const MyNavigationBar(),
        appBar: AppBar(
          title: Text('Welcome to TunedIn'),
        ),
        body: Center(
          child: isBusy
              ? CircularProgressIndicator()
              : isLoggedIn
                  ? Profile(logoutAction, name, picture)
                  : Login(loginAction, errorMessage),
        ),
      ),
    );
  }

  // This method will receive and parse an ID token as a Base64 encoded
  // string into a Map object. Exploring the ID token fetches user's full name
  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  // This method takes an accessToken and sends it as a bearer authorization
  // header to the /userinfo endpoint. The result is a JSON object that's parsed
  // and returned in a Future<Map> object. This method fetches the profile
  // picture
  Future<Map> getUserDetails(String accessToken) async {
    const url = 'https://$AUTH0_DOMAIN/userinfo';
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  // handles the end-to-end flow: from starting a PKCE authorization code
  // flow to getting authorization code in the callback and exchanging it for a
  // set of artifact tokens.
  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final AuthorizationTokenResponse result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AUTH0_CLIENT_ID,
          AUTH0_REDIRECT_URI + "/",
          issuer: 'https://$AUTH0_DOMAIN',
          scopes: ['openid', 'profile', 'offline_access'],
          // promptValues: ['login']
        ),
      );

      final idToken = parseIdToken(result.idToken);
      final profile = await getUserDetails(result.accessToken);

      await secureStorage.write(
          key: 'refresh_token', value: result.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
      });
    } catch (e, s) {
      print('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  // The logoutAction() method first removes any refreshToken from storage,
  // then changes the isLoggedIn state back to false.
  void logoutAction() async {
    void logoutAction() async {
      await secureStorage.delete(key: 'refresh_token');
      setState(() {
        isLoggedIn = false;
        isBusy = false;
      });
    }
  }

// Broadly: initAction and initState handle the user authentication state
// initState() checks if there is any existing refreshToken. If so, it tries
// to retrieve a new accessToken by calling the appAuth.token() method.
// initAction() renews accessToken regardless of the validity of any existing
// access token.
  @override
  void initState() {
    initAction();
    super.initState();
  }

  void initAction() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    setState(() {
      isBusy = true;
    });

    try {
      final response = await appAuth.token(TokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken,
      ));

      final idToken = parseIdToken(response.idToken);
      final profile = await getUserDetails(response.accessToken);

      secureStorage.write(key: 'refresh_token', value: response.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
      });
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }
}


// /// -----------------------------------
// ///          External Packages
// /// -----------------------------------

// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;
// import 'package:flutter_appauth/flutter_appauth.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// final FlutterAppAuth appAuth = FlutterAppAuth();
// const FlutterSecureStorage secureStorage = FlutterSecureStorage();

// /// -----------------------------------
// ///           Auth0 Variables
// /// -----------------------------------

// const String AUTH0_DOMAIN = 'dev-kt5qj3uqxps4pfhg.us.auth0.com';
// const String AUTH0_CLIENT_ID = 'BHLNHUjsA4IQbAWL7WlX6ccJtVVJCojR';

// const String AUTH0_REDIRECT_URI = 'com.auth0.tunedin://login-callback';
// const String AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

// /// -----------------------------------
// ///           Profile Widget
// /// -----------------------------------

// class Profile extends StatelessWidget {
//   final Future<void> Function() logoutAction;
//   String name = "";
//   String picture = "";

//   Profile(this.logoutAction, this.name, this.picture, {Key key=new Key("")})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           width: 150,
//           height: 150,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.blue, width: 4),
//             shape: BoxShape.circle,
//             image: DecorationImage(
//               fit: BoxFit.fill,
//               image: NetworkImage(picture ?? ''),
//             ),
//           ),
//         ),
//         const SizedBox(height: 24),
//         Text('Name: $name'),
//         const SizedBox(height: 48),
//         RaisedButton(
//           onPressed: () async {
//             await logoutAction();
//           },
//           child: const Text('Logout'),
//         ),
//       ],
//     );
//   }
// }

// /// -----------------------------------
// ///            Login Widget
// /// -----------------------------------

// class Login extends StatelessWidget {
//   final Future<void> Function() loginAction;
//   final String loginError;

//   const Login(this.loginAction, this.loginError, {Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         RaisedButton(
//           onPressed: () async {
//             await loginAction();
//           },
//           child: const Text('Login'),
//         ),
//         Text(loginError ?? ''),
//       ],
//     );
//   }
// }

// /// -----------------------------------
// ///                 App
// /// -----------------------------------

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// /// -----------------------------------
// ///              App State
// /// -----------------------------------

// class _MyAppState extends State<MyApp> {
//   bool isBusy = false;
//   bool isLoggedIn = false;
//   String errorMessage;
//   String name;
//   String picture;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Auth0 Demo',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Auth0 Demo'),
//         ),
//         body: Center(
//           child: isBusy
//               ? const CircularProgressIndicator()
//               : isLoggedIn
//                   ? Profile(logoutAction, name, picture)
//                   : Login(loginAction, errorMessage),
//         ),
//       ),
//     );
//   }

//   Map<String, Object> parseIdToken(String idToken) {
//     final List<String> parts = idToken.split('.');
//     assert(parts.length == 3);

//     return jsonDecode(
//         utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
//   }

//   Future<Map<String, Object>> getUserDetails(String accessToken) async {
//     const String url = 'https://$AUTH0_DOMAIN/userinfo';
//     final http.Response response = await http.get(
//       url,
//       headers: <String, String>{'Authorization': 'Bearer $accessToken'},
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to get user details');
//     }
//   }

//   Future<void> loginAction() async {
//     setState(() {
//       isBusy = true;
//       errorMessage = '';
//     });

//     try {
//       final AuthorizationTokenResponse result =
//           await appAuth.authorizeAndExchangeCode(
//         AuthorizationTokenRequest(
//           AUTH0_CLIENT_ID,
//           AUTH0_REDIRECT_URI,
//           issuer: 'https://$AUTH0_DOMAIN',
//           scopes: <String>['openid', 'profile', 'offline_access'],
//           // promptValues: ['login']
//         ),
//       );

//       final Map<String, Object> idToken = parseIdToken(result.idToken);
//       final Map<String, Object> profile =
//           await getUserDetails(result.accessToken);

//       await secureStorage.write(
//           key: 'refresh_token', value: result.refreshToken);

//       setState(() {
//         isBusy = false;
//         isLoggedIn = true;
//         name = idToken['name'];
//         picture = profile['picture'];
//       });
//     } on Exception catch (e, s) {
//       debugPrint('login error: $e - stack: $s');

//       setState(() {
//         isBusy = false;
//         isLoggedIn = false;
//         errorMessage = e.toString();
//       });
//     }
//   }

//   Future<void> logoutAction() async {
//     await secureStorage.delete(key: 'refresh_token');
//     setState(() {
//       isLoggedIn = false;
//       isBusy = false;
//     });
//   }

//   @override
//   void initState() {
//     initAction();
//     super.initState();
//   }

//   Future<void> initAction() async {
//     final String storedRefreshToken =
//         await secureStorage.read(key: 'refresh_token');
//     if (storedRefreshToken == null) return;

//     setState(() {
//       isBusy = true;
//     });

//     try {
//       final TokenResponse response = await appAuth.token(TokenRequest(
//         AUTH0_CLIENT_ID,
//         AUTH0_REDIRECT_URI,
//         issuer: AUTH0_ISSUER,
//         refreshToken: storedRefreshToken,
//       ));

//       final Map<String, Object> idToken = parseIdToken(response.idToken);
//       final Map<String, Object> profile =
//           await getUserDetails(response.accessToken);

//       await secureStorage.write(
//           key: 'refresh_token', value: response.refreshToken);

//       setState(() {
//         isBusy = false;
//         isLoggedIn = true;
//         name = idToken['name'];
//         picture = profile['picture'];
//       });
//     } on Exception catch (e, s) {
//       debugPrint('error on refresh token: $e - stack: $s');
//       await logoutAction();
//     }
//   }
// }