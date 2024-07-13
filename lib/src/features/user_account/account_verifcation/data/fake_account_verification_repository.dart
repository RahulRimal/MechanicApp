import '../../../../shared/domain/user.dart';
import 'account_verification_repository.dart';

class FakeAccountVerificationRepository
    implements AccountVerificationRepository {
  @override
  Future<bool> checkRecoveryOtp(String code, String otpIdx) {
    // TODO: implement checkRecoveryOtp
    throw UnimplementedError();
  }

  @override
  Future<User> verifyAccountOtp(String otpIdx, String newPassword,
      String userIdentifier, String otpCode) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> requestAccountRecoveryOtpPassword(
      String oldPassword) {
    // TODO: implement requestAccountRecoveryOtpPassword
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> requestAccountRecoveryOtpUid(String userId) {
    // TODO: implement requestAccountRecoveryOtpUid
    throw UnimplementedError();
  }

  @override
  Future<bool> checkVerificationOtp(String code, String otpIdx) {
    // TODO: implement checkVerificationOtp
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> requestVerificationOtp(String userId) {
    // TODO: implement requestAccountVerificationOtpUid
    throw UnimplementedError();
  }

  @override
  Future<bool> verifyIdentifiertOtp(
      String otpIdx, String userIdentifier, String otpCode) {
    // TODO: implement verifyIdentifiertOtp
    throw UnimplementedError();
  }

  @override
  Future<bool> generateIdentifiertOtp(String userIdentifier) {
    // TODO: implement generateIdentifiertOtp
    throw UnimplementedError();
  }
}
