import 'package:bato_mechanic/main.dart';
import 'package:bato_mechanic/src/shared/repositories/mechanic_repository/api_mechanic_repository.dart';
import 'package:bato_mechanic/src/features/reviews_and_rating/domain/reviews_and_rating/reviews_and_rating.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/mechanic.dart';
import 'fake_mechanic_repository.dart';

part 'mechanic_repository.g.dart';

abstract class MechanicRepository {
  Future<List<Mechanic>> fetchRecommendedMechanics(
      String vehicleCategoryIdx, String serviceIdx);

  Future<Mechanic> fetchMechanicInfo(String mechanicId);
  Future<ReviewAndRating> rateAndReviewMechanic(
      String mechanicIdx, String repairRequestIdx, int rating, String review);
}

@riverpod
MechanicRepository mechanicRepository(MechanicRepositoryRef ref) =>
    SHOW_FAKE ? FakeMechanicRepository() : APIMechanicRepository(ref: ref);

@riverpod
Future<Mechanic> fetchMechanicInfo(
    FetchMechanicInfoRef ref, String mechanicId) {
  return ref.watch(mechanicRepositoryProvider).fetchMechanicInfo(mechanicId);
}

@riverpod
Future<List<Mechanic>> fetchRecommendedMechanics(
        FetchRecommendedMechanicsRef ref,
        String vehicleCategoryIdx,
        String serviceIdx) =>
    ref
        .watch(mechanicRepositoryProvider)
        .fetchRecommendedMechanics(vehicleCategoryIdx, serviceIdx);
