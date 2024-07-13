import 'package:bato_mechanic/src/shared/repositories/mechanic_repository/mechanic_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_mechanic_screen_controller.g.dart';

@riverpod
class ReviewMechanicScreenController extends _$ReviewMechanicScreenController {
  @override
  FutureOr<void> build() {
    // pass
  }

  Future<bool> reviewMechanic(String mechanicIdx, String repairRequestIdx,
      int stars, String reviewText) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref
        .read(mechanicRepositoryProvider)
        .rateAndReviewMechanic(
            mechanicIdx, repairRequestIdx, stars, reviewText));
    return !state.hasError;
  }
}
