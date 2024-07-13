import 'package:bato_mechanic/main.dart';
import 'package:bato_mechanic/src/features/auth/data/remote/api_remote_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/domain/user.dart';
import 'fake_remote_auth_repository.dart';

part 'remote_auth_repository.g.dart';

abstract class RemoteAuthRepository {
  Future<User> signInWithIdAndPassword(String uId, String password);
  Future<User> googleSignIn();
  Future<void> refreshToken(String refreshToken);
  Future<User> createUserWithIdAndPassword(
      String uId, String password, String fullName);
  Future<void> createUserWithoutPassword(String uId, String name);
  Future<User> getCurrentUserInfo(String token);
  Future<void> signOut(Ref ref);
}

@riverpod
RemoteAuthRepository authRepository(AuthRepositoryRef ref) {
  if (SHOW_FAKE) {
    return FakeRemoteAuthRepository();
  } else {
    return APIRemoteAuthRepository(ref: ref);
  }
}
