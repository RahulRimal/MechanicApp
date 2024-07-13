import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/domain/user.dart';
import '../../../../shared/providers/user_settings.dart';
import 'remote_auth_repository.dart';

class FakeRemoteAuthRepository implements RemoteAuthRepository {
  @override
  Future<User> createUserWithIdAndPassword(
      String uId, String password, String fullName) async {
    await Future.delayed(const Duration(seconds: 2));
    return User.fromJson({
      "idx": "itLGCnD7vf9P7eucZf3Kgo",
      "name": "Krishna Rimal",
      "email": null,
      "phone": "9808144809",
      "image": null,
      "primary_role": "Consumer",
      "roles": [],
      "dob_type": "AD",
    });
  }

  @override
  Future<User> signInWithIdAndPassword(String uId, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return jsonDecode(
        '{"refresh": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwMTYyODcwNiwiaWF0IjoxNzAxNTQyMzA2LCJqdGkiOiIwNTA3NTExNWUyYmI0MTIzODc4OTZiZDBmZjE4OTZlYiIsInVzZXJfaWQiOjEzfQ.c_iA-kFOi_P_b29pVR2UK_R4I3S03VUaBSC0KblwCSQ", "access": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzAxNjI4NzA2LCJpYXQiOjE3MDE1NDIzMDYsImp0aSI6ImIyYjk2ZTVmYmVjZDRhNzFiNWJmODI5YzgzM2E5NjZiIiwidXNlcl9pZCI6MTN9.nZCaUPmEyefC7FnQkkC7iiu2h5gLffuvjNyeHp6Iy7c"}');
  }

  @override
  Future<User> getCurrentUserInfo(String token) async {
    await Future.delayed(const Duration(seconds: 1));
    final User user = User.fromJson(
      {
        "idx": "itLGCnD7vf9P7eucZf3Kgo",
        "name": "Krishna Rimal",
        "email": null,
        "phone": "9808144809",
        "image": null,
        "primary_role": "Consumer",
        "roles": [],
        "additional_attributes": {},
        "dob_type": "AD",
      },
    );
    return user;
  }

  @override
  Future<void> signOut(Ref ref) async {
    ref.read(sharedPreferencesProvider).remove('access');
    ref.read(sharedPreferencesProvider).remove('refresh');
  }

  @override
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    await Future.delayed(const Duration(seconds: 1));
    return jsonDecode(
      '{"access": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzAxNjI4NzA2LCJpYXQiOjE3MDE1NDIzMDYsImp0aSI6ImIyYjk2ZTVmYmVjZDRhNzFiNWJmODI5YzgzM2E5NjZiIiwidXNlcl9pZCI6MTN9.nZCaUPmEyefC7FnQkkC7iiu2h5gLffuvjNyeHp6Iy7c"}',
    );
  }

  @override
  Future<User> googleSignIn() {
    // TODO: implement googleSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> createUserWithoutPassword(String uId, String name) {
    // TODO: implement createUserWithoutPassword
    throw UnimplementedError();
  }
}
