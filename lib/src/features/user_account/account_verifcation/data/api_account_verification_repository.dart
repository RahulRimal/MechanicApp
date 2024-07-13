import 'dart:io';

import 'package:bato_mechanic/src/features/user_account/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/domain/user.dart';
import '../../../../shared/providers/user_settings.dart';
import '../../../../shared/utils/constants/managers/api_values_manager.dart';
import '../../../../shared/utils/http/http_client.dart';
import '../../../auth/application/auth_state.dart';
import 'account_verification_repository.dart';
import 'package:http/http.dart' as http;

class ApiAccountVerificationRepository
    implements AccountVerificationRepository {
  ApiAccountVerificationRepository({required this.ref});

  final Ref ref;

  @override
  Future<Map<String, dynamic>> requestVerificationOtp(String userId,
      {bool forAccountVerificatin = false}) async {
    var url = Uri.parse(
        '${RemoteManager.BASE_URI}autho/account_verification/send_otp_uid/');

    var response = await HttpHelper.guard(
        () => http.post(
              url,
              body: {
                "user_identifier": userId,
                "for_account_verification": forAccountVerificatin,
              },
            ),
        ref);
    return response;
  }

  @override
  Future<bool> checkVerificationOtp(String code, String otpIdx) async {
    var url = Uri.parse(
        '${RemoteManager.BASE_URI}autho/account_verification/check_otp/');

    await HttpHelper.guard(
        () => http.post(
              url,
              body: {
                "code": code,
                "otp": otpIdx,
              },
            ),
        ref);

    // directly return true because if error occurs then it will throw an exception before reaching here
    return true;
  }

  @override
  Future<User> verifyAccountOtp(String otpIdx, String newPassword,
      String userIdentifier, String otpCode) async {
    // Returns the customer user after setting the new password
    var url = Uri.parse(
        '${RemoteManager.BASE_URI}autho/account_verification/$otpIdx/verify_account_otp/');

    var response = await HttpHelper.guard(
        () => http.post(
              url,
              body: {
                "new_password": newPassword,
                "user_identifier": userIdentifier,
                "otp_code": otpCode,
                "for_account_verification": true.toString(),
              },
            ),
        ref);

    String uIdx = response['user_idx'] as String;
    url = Uri.parse('${RemoteManager.BASE_URI}autho/create-token/');

    response = await HttpHelper.guard(
        () => http.post(url, body: {
              "user_identifier": ref.read(userIdentifierProvider),
              "password": newPassword,
            }),
        ref);

    String accessToken = response['access'] as String;
    ref.read(sharedPreferencesProvider).setString('access', accessToken);
    ref
        .read(sharedPreferencesProvider)
        .setString('refresh', response['refresh'] as String);

    url = Uri.parse('${RemoteManager.BASE_URI}vehicle-repair/customers/');
    response = await HttpHelper.guard(
        () => http.post(
              url,
              headers: {HttpHeaders.authorizationHeader: 'BM $accessToken'},
              body: {
                "user_idx": uIdx,
              },
            ),
        ref);

    final User user = User.fromJson(response);

    ref.read(authStateNotifierProvider.notifier).logIn(user);
    return user;
  }

  @override
  Future<bool> verifyIdentifiertOtp(
      String otpIdx, String userIdentifier, String otpCode) async {
    var url = Uri.parse(
        '${RemoteManager.BASE_URI}autho/account_verification/$otpIdx/verify_otp/');

    await HttpHelper.guard(
        () => http.post(
              url,
              headers: {
                HttpHeaders.authorizationHeader:
                    'BM ${ref.read(sharedPreferencesProvider).getString("access")}',
              },
              body: {
                "user_identifier": userIdentifier,
                "otp_code": otpCode,
                "for_account_verification": false.toString(),
              },
            ),
        ref);

    // After successful verification, set the email so email is not null in the app (this is to save an additional request to the server)
    User user = ref.read(authStateNotifierProvider).user!;
    if (userIdentifier.contains('@')) {
      user = user.copyWith(email: userIdentifier);
    } else {
      user = user.copyWith(phone: userIdentifier);
    }
    ref.read(authStateNotifierProvider.notifier).setUser(user);

    return true;
  }

  @override
  Future<bool> generateIdentifiertOtp(String userIdentifier) async {
    var url = Uri.parse(
        '${RemoteManager.BASE_URI}autho/account_verification/send_otp_uid/');

    var response = await HttpHelper.guard(
        () => http.post(
              url,
              headers: {
                HttpHeaders.authorizationHeader:
                    'BM ${ref.read(sharedPreferencesProvider).getString("access")}',
              },
              body: {
                "user_identifier": userIdentifier,
              },
            ),
        ref);

    ref
        .read(verifyOtpIdxProvider.notifier)
        .setOtpIdx(response['verification']['idx']);

    return true;
  }
}
