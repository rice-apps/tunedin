import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:rice_music_sharing/data/repositories/storage_repository.dart';

import '../models/user_model.dart';
import '../../constants.dart';

class AuthRepository {
  final String baseUrl = Platform.isAndroid ? backendURLAndroid : backendURL;
  StorageRepository storage = StorageRepository();

  Client client = Client();

  Future<String?> get _token async {
    String? token = await storage.readSecureData(keyToken);
    return token;
  }

  Future<void> signIn({required String ticket}) async {
    final response = await client.get(
      Uri.parse('$baseUrl/auth'),
      headers: {'ticket': ticket},
    );
    final result = json.decode(response.body);

    if (result != null && result['token'] != null) {
      // save this user's token and handle
      storage.writeSecureData(keyToken, result['token']);
      storage.writeSecureData(keyHandle, result['handle']);
    } else if (result['token'] == null) {
      throw Exception(result['message']);
    } else {
      throw Exception('Unknown sign-in error.');
    }
  }

  Future<void> signOut() async {
    await storage.deleteSecureData(keyToken);
  }

  Future<UserModel?> get user async {
    String? handle = await storage.readSecureData(keyHandle);
    if (handle != null) {
      final response =
          await client.get(Uri.parse('$baseUrl/users/$handle'), headers: {
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
