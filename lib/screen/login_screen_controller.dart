import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rice_music_sharing/data/repositories/auth_repository.dart';

class LoginScreenController extends StateNotifier<AsyncValue<void>> {
  LoginScreenController({required this.authRepository})
      : super(const AsyncData(null));
  final AuthRepository authRepository;

  Future<void> signIn({required String ticket}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.signIn(ticket: ticket),
    );
  }
}

final loginScreenControllerProvider =
    StateNotifierProvider.autoDispose<LoginScreenController, AsyncValue<void>>(
        (ref) {
  return LoginScreenController(
    authRepository: ref.watch(authRepositoryProvider),
  );
});
