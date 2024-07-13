import 'package:bato_mechanic/src/features/user_account/account_verifcation/data/account_verification_repository.dart';
import 'package:bato_mechanic/src/features/user_account/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "identifier_verification_otp_confirmation_screen_controller.g.dart";

@riverpod
class IdentifierVerificationOtpConfirmationScreenController
    extends _$IdentifierVerificationOtpConfirmationScreenController {
  @override
  FutureOr<void> build() async {}

  Future<bool> checkOtp(String code, String otpIdx) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref
        .read(accountVerificationRepositoryProvider)
        .checkVerificationOtp(code, otpIdx));

    return !state.hasError;
  }

  Future<bool> verifyOtp(String code) async {
    state = const AsyncLoading();

    String? uid = ref.read(userIdentifierProvider);
    if (uid == null) {
      state = AsyncError("Couldn't verify", StackTrace.current);
      return false;
    }
    String? otpIdx = ref.read(verifyOtpIdxProvider);
    if (otpIdx == null) {
      state = AsyncError("Couldn't verify", StackTrace.current);
      return false;
    }

    state = await AsyncValue.guard(() => ref
        .read(accountVerificationRepositoryProvider)
        .verifyIdentifiertOtp(otpIdx, uid, code));
    return !state.hasError;
  }
}
