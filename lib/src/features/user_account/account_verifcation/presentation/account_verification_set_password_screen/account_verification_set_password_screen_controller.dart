import 'package:bato_mechanic/src/features/user_account/account_recovery/data/account_recovery_repository.dart';
import 'package:bato_mechanic/src/features/user_account/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/account_verification_repository.dart';

part "account_verification_set_password_screen_controller.g.dart";

@riverpod
class AccountVerificationSetPasswordScreenController
    extends _$AccountVerificationSetPasswordScreenController {
  @override
  FutureOr<String?> build() async {
    return null;
  }

  Future<bool> changePassword(String newPassword) async {
    state = const AsyncLoading();

    String? userId = ref.read(userIdentifierProvider);
    if (userId == null) {
      state = AsyncError("User id not found", StackTrace.current);
      return false;
    }

    String? otpCode = ref.read(otpCodeProvider);
    if (otpCode == null) {
      state = AsyncError("Invalid otp code", StackTrace.current);
      return false;
    }

    var response = await AsyncValue.guard(() => ref
        .read(accountVerificationRepositoryProvider)
        .verifyAccountOtp(ref.read(verifyOtpIdxProvider) ?? "", newPassword,
            userId, otpCode));

    if (response.hasError) {
      state = AsyncError(response.error!, StackTrace.current);
    } else {
      state = const AsyncData(null);
    }

    return !state.hasError;
  }
}
