import 'package:bato_mechanic/src/features/auth/data/remote/remote_auth_repository.dart';
import 'package:bato_mechanic/src/features/repair_request/data/remote/repair_request_repository/repair_request_repository.dart';
import 'package:bato_mechanic/src/shared/repositories/user_repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_screen_controller.g.dart';

@riverpod
class SplashScreenController extends _$SplashScreenController {
  @override
  FutureOr<void> build() {
    // pass
  }

  Future<bool> hasRepairRequest(String userId) async {
    await Future.delayed(const Duration(seconds: 2));
    final response = await ref
        .read(repairRequestRepositoryProvider)
        .fetchUserRepairRequests();

    return response.isNotEmpty;
  }

  Future<bool> fetchUserInfo(String token) async {
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).getCurrentUserInfo(token));
    return !state.hasError;
  }

  Future<bool> refreshToken(String refreshToken) async {
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).refreshToken(refreshToken));
    return !state.hasError;
  }
}
