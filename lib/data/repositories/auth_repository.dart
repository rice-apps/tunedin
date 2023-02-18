import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../../constants.dart';

class AuthRepository {
  final String baseUrl = Platform.isAndroid
      ? dotenv.get('BACKEND_URL_ANDROID')
      : dotenv.get('BACKEND_URL');

  Client client = Client();

  Future<String?> get _token async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(keyToken);
    if (token != null) {
      return token;
    } else {
      // how to deal with no token
      return null;
    }
  }

  Future<void> signIn({required String ticket}) async {
    final response = await client.get(
      Uri.parse('$baseUrl/auth'),
      headers: {'ticket': ticket},
    );
    final result = json.decode(response.body);

    if (result != null && result['success']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // save this user's token and username
      prefs.setString(keyToken, result['user']['token']);
      prefs.setString(keyUsername, result['user']['username']);
    } else if (!result['success']) {
      throw Exception(result['message']);
    } else {
      throw Exception('Unknown sign-in error.');
    }
  }

  Future<UserModel?> get user async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString(keyUsername);
    if (username != null) {
      final response =
          await client.get(Uri.parse('$baseUrl/users/$username'), headers: {
        'Authorization': 'Bearer $_token',
      });
      final result = json.decode(response.body);
      return UserModel.fromJson(result['user']);
    } else {
      // incomplete account -> onboarding
      return null;
    }
  }
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository());
