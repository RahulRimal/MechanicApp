import 'package:bato_mechanic/src/features/user_account/account_verifcation/data/account_verification_repository.dart';
import 'package:bato_mechanic/src/shared/repositories/user_repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "edit_profile_screen_controller.g.dart";

@riverpod
class EditProfileScreenController extends _$EditProfileScreenController {
  late Object? key;
  @override
  FutureOr<void> build() async {
    key = Object();
    ref.onDispose(() {
      key = null;
    });
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    state = const AsyncLoading();
    final key = this.key;

    var resp = await AsyncValue.guard(
        () => ref.read(userRepositoryProvider).updateProfile(data));

    if (key == this.key) {
      state = resp;
    }

    return !state.hasError;
  }

  Future<bool> generateIdentifierVerificationOtp(String userIdentifier) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref
        .read(accountVerificationRepositoryProvider)
        .generateIdentifiertOtp(userIdentifier));
    return !state.hasError;
  }
}
