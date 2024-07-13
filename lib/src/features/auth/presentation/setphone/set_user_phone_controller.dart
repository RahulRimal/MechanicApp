import 'package:bato_mechanic/src/shared/repositories/user_repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'set_user_phone_controller.g.dart';

@riverpod
class SetUserPhoneController extends _$SetUserPhoneController {
  bool _mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => _mounted = false);
  }

  Future<bool> setUserPhoneNumber(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    if (_mounted) {
      state = await AsyncValue.guard(
          () => ref.read(userRepositoryProvider).updateProfile(data));
    }
    return !state.hasError;
  }
}
