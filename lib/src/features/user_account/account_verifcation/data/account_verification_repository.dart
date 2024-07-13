import 'package:bato_mechanic/main.dart';
import 'package:bato_mechanic/src/features/user_account/account_verifcation/data/fake_account_verification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/domain/user.dart';
import 'api_account_verification_repository.dart';

part 'account_verification_repository.g.dart';

abstract class AccountVerificationRepository {
  Future<Map<String, dynamic>> requestVerificationOtp(String userId);
  Future<bool> checkVerificationOtp(String code, String otpIdx);
  Future<User> verifyAccountOtp(
      String otpIdx, String newPassword, String userIdentifier, String otpCode);

  Future<bool> generateIdentifiertOtp(String userIdentifier);
  Future<bool> verifyIdentifiertOtp(
      String otpIdx, String userIdentifier, String otpCode);
}

@riverpod
AccountVerificationRepository accountVerificationRepository(
        AccountVerificationRepositoryRef ref) =>
    SHOW_FAKE
        ? FakeAccountVerificationRepository()
        : ApiAccountVerificationRepository(ref: ref);
