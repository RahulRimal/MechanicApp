import 'package:bato_mechanic/main.dart';
import 'package:bato_mechanic/src/shared/repositories/user_repository/api_user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/reviews_and_rating/domain/reviews_and_rating/reviews_and_rating.dart';
import '../../domain/user.dart';
import 'fake_user_repository.dart';

part 'user_repository.g.dart';

abstract class UserRepository {
  Future<User> fetchUserInfo(String userIdx);
  Future<User> fetchUserInfoByUidx(String uIdx);

  Future<void> changePassword(String oldPass, String newPass);
  // Update profile returns bool because server returns only the user object and not the customer which can't be used to construct the user here. Service should fetch the customer data after updating the profile successfully
  Future<User> updateProfile(Map<String, dynamic> info);
}

@riverpod
UserRepository userRepository(UserRepositoryRef ref) =>
    SHOW_FAKE ? FakeUserRepository() : APIUserRepository(ref: ref);

@riverpod
Future<User> fetchUserInfo(FetchUserInfoRef ref, String userIdx) =>
    ref.watch(userRepositoryProvider).fetchUserInfo(userIdx);
@riverpod
Future<User> fetchUserInfoByUidx(FetchUserInfoByUidxRef ref, String uIdx) =>
    ref.watch(userRepositoryProvider).fetchUserInfoByUidx(uIdx);
