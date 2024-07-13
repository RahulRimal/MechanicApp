import 'package:bato_mechanic/src/features/user_account/account_verifcation/data/account_verification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "account_verification_otp_confirmation_screen_controller.g.dart";

@riverpod
class AccountVerificationOtpConfirmationScreenController
    extends _$AccountVerificationOtpConfirmationScreenController {
  @override
  FutureOr<void> build() async {}

  Future<bool> checkOtp(String code, String otpIdx) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref
        .read(accountVerificationRepositoryProvider)
        .checkVerificationOtp(code, otpIdx));

    return !state.hasError;
  }
}
