import 'package:bato_mechanic/src/features/auth/data/remote/remote_auth_repository.dart';
import 'package:bato_mechanic/src/features/repair_request/data/remote/repair_request_repository/repair_request_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen_controller.g.dart';

@riverpod
class HomeScreenController extends _$HomeScreenController {
  @override
  FutureOr<void> build() {
    // pass
  }

  Future<bool> fetchUserActiveRequest() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref
        .read(repairRequestRepositoryProvider)
        .fetchUserActiveRepairRequests());
    return !state.hasError;
  }

  Future<bool> fetchUserRepairRequests() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() =>
        ref.read(repairRequestRepositoryProvider).fetchUserRepairRequests());
    return !state.hasError;
  }

  Future<bool> fetchUserInfo(String token) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).getCurrentUserInfo(token));
    return !state.hasError;
  }

  Future<bool> refreshToken(String refreshToken) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).refreshToken(refreshToken));
    return !state.hasError;
  }
}
