import 'package:bato_mechanic/src/features/auth/data/remote/remote_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_screen_controller.g.dart';

@riverpod
class SignUpScreenController extends _$SignUpScreenController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<bool> createUserWithIdAndPassword(
      String uId, String password, String fullName) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref
        .read(authRepositoryProvider)
        .createUserWithIdAndPassword(uId, password, fullName));
    return !state.hasError;
  }

  Future<bool> createUserWithoutPassword(String uId, String fullName) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref
        .read(authRepositoryProvider)
        .createUserWithoutPassword(uId, fullName));
    return !state.hasError;
  }

  Future<bool> googleSignIn() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).googleSignIn());
    return !state.hasError;
  }
}
