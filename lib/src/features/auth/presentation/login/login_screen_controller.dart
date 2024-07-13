import 'package:bato_mechanic/src/features/auth/data/remote/remote_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_screen_controller.g.dart';

@riverpod
class LoginScreenController extends _$LoginScreenController {
  @override
  FutureOr<void> build() async {}

  Future<bool> signInWithIdAndPassword(String uId, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref
        .read(authRepositoryProvider)
        .signInWithIdAndPassword(uId, password));
    return !state.hasError;
  }

  Future<bool> googleSignIn() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).googleSignIn());
    return !state.hasError;
  }
}
