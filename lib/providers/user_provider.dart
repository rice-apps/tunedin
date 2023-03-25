import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/user_model.dart';
import '../repository/user_repository.dart';
import 'http_provider.dart';

final userRepositoryProvider = Provider<UserRepository>(
        (ref) => UserRepository(apiClient: ref.read(httpProvider)));
final userListProvider = FutureProvider.autoDispose<List<UserModel>>(
        (ref) => ref.read(userRepositoryProvider).fetchUsers());