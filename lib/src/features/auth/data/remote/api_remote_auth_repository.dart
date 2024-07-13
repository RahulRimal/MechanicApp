import 'dart:convert';
import 'dart:io';

import 'package:bato_mechanic/src/features/auth/application/auth_state.dart';
import 'package:bato_mechanic/src/features/user_account/providers.dart';
import 'package:bato_mechanic/src/shared/utils/http/http_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../shared/data/fcm_repository.dart';
import '../../../../shared/domain/user.dart';
import '../../../../shared/providers/user_settings.dart';
import '../../../../shared/utils/constants/managers/api_values_manager.dart';

import 'package:http/http.dart' as http;

import 'remote_auth_repository.dart';

class APIRemoteAuthRepository implements RemoteAuthRepository {
  APIRemoteAuthRepository({required this.ref});

  final Ref ref;

  @override
  Future<User> createUserWithIdAndPassword(
      String uId, String password, String fullName) async {
    var url =
        Uri.parse('${RemoteManager.BASE_URI}autho/users_management/register/');
    var response = await HttpHelper.guard(
        () => http.post(url, body: {
              "user_identifier": uId,
              "password": password,
              "name": fullName,
            }),
        ref);

    final String uIdx = response["idx"];

    url = Uri.parse('${RemoteManager.BASE_URI}autho/create-token/');

    response = await HttpHelper.guard(
        () => http
            .post(url, body: {"user_identifier": uId, "password": password}),
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
  Future<User> signInWithIdAndPassword(String uId, String password) async {
    var url = Uri.parse('${RemoteManager.BASE_URI}autho/create-token/');

    final response = await HttpHelper.guard(
        () => http
            .post(url, body: {"user_identifier": uId, "password": password}),
        ref);

    String access = response['access'] as String;

    ref.read(sharedPreferencesProvider).setString('access', access);
    ref
        .read(sharedPreferencesProvider)
        .setString('refresh', response['refresh'] as String);

    final User user = await getCurrentUserInfo(access);
    ref.read(authStateNotifierProvider.notifier).logIn(user);
    return user;
  }

  @override
  Future<void> refreshToken(String refreshToken) async {
    var url = Uri.parse('${RemoteManager.BASE_URI}autho/refresh-token/');

    final response = await HttpHelper.guard(
        () => http.post(url, body: {"refresh": refreshToken}), ref);

    ref
        .read(sharedPreferencesProvider)
        .setString('access', response['access'] as String);
  }

  @override
  Future<User> getCurrentUserInfo(String token) async {
    var url =
        Uri.parse('${RemoteManager.BASE_URI}vehicle-repair/customers/me/');

    final response = await HttpHelper.guard(
        () => http.get(url, headers: {
              HttpHeaders.authorizationHeader: 'BM $token',
            }),
        ref);
    final User user = User.fromJson(response);
    ref.read(authStateNotifierProvider.notifier).setUser(user);
    return user;
  }

  @override
  Future<void> signOut(Ref ref) async {
    ref.read(sharedPreferencesProvider).remove('access');
    ref.read(sharedPreferencesProvider).remove('refresh');
  }

  @override
  Future<User> googleSignIn() async {
    String clientId = dotenv.env['GOOGLE_SERVER_CLIENT_ID'] as String;
    final googleSignIn = GoogleSignIn(
      // client id of server
      clientId: clientId,
    );

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final String idToken = googleAuth.idToken!;
    // send the ID token to backend

    var url = Uri.parse('${RemoteManager.BASE_URI}social-auth/google/');
    var response = await HttpHelper.guard(
        () => http.post(
              url,
              headers: {
                "Accept": "application/json; charset=utf-8",
                "Access-Control-Allow-Origin":
                    "*", // Required for CORS support to work
                "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
                HttpHeaders.contentTypeHeader: "application/json",
              },
              body: json.encode({
                "auth_token": idToken,
              }),
            ),
        ref);
    ref
        .read(sharedPreferencesProvider)
        .setString('access', response['tokens']['access'] as String);
    ref
        .read(sharedPreferencesProvider)
        .setString('refresh', response['tokens']['refresh'] as String);

    final User user = User.fromJson(response['user']);
    ref.read(authStateNotifierProvider.notifier).logIn(user);

    // register the device for notification after sign in happens
    ref.read(fcmDeviceRepositoryProvider).registerNewDevice();
    return user;
  }

  @override
  Future<void> createUserWithoutPassword(String uId, String fullName) async {
    var url =
        Uri.parse('${RemoteManager.BASE_URI}autho/users_management/register/');
    var response = await HttpHelper.guard(
        () => http.post(url, body: {
              "user_identifier": uId,
              "name": fullName,
            }),
        ref);

    ref
        .read(verifyOtpIdxProvider.notifier)
        .setOtpIdx(response["verification"]["idx"]);
  }
}
