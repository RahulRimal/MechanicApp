import 'dart:io';

import 'package:bato_mechanic/src/shared/repositories/mechanic_repository/mechanic_repository.dart';
import 'package:bato_mechanic/src/features/reviews_and_rating/domain/reviews_and_rating/reviews_and_rating.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/mechanic.dart';
import '../../providers/user_settings.dart';
import '../../utils/constants/managers/api_values_manager.dart';
import '../../utils/http/http_client.dart';
import 'package:http/http.dart' as http;

class APIMechanicRepository extends MechanicRepository {
  APIMechanicRepository({required this.ref});

  final Ref ref;

  @override
  Future<Mechanic> fetchMechanicInfo(String mechanicId) async {
    var url = Uri.parse(
        '${RemoteManager.BASE_URI}vehicle-repair/mechanics/$mechanicId');

    final response = await HttpHelper.guard(
        () => http.get(url, headers: {
              HttpHeaders.authorizationHeader:
                  'BM ${ref.read(sharedPreferencesProvider).getString("access")}',
            }),
        ref);

    return Mechanic.fromJson(response);
  }

  @override
  Future<ReviewAndRating> rateAndReviewMechanic(String mechanicIdx,
      String repairRequestIdx, int rating, String review) async {
    var url = Uri.parse('${RemoteManager.BASE_URI}vehicle-repair/reviews/');
    final response = await HttpHelper.guard(
        () => http.post(url, headers: {
              HttpHeaders.authorizationHeader:
                  'BM ${ref.read(sharedPreferencesProvider).getString("access")}',
            }, body: {
              "rating": rating.toString(),
              "review": review,
              "mechanic": mechanicIdx,
              "repair_request_idx": repairRequestIdx,
            }),
        ref);
    return ReviewAndRating.fromJson(response);
  }

  @override
  Future<List<Mechanic>> fetchRecommendedMechanics(
      String vehicleCategoryIdx, String serviceIdx) async {
    var url = Uri.parse(
        '${RemoteManager.BASE_URI}autho/user_info/recommended_mechanics/?vehicle_category_speciality=$vehicleCategoryIdx&service_speciality=$serviceIdx');
    var response = await HttpHelper.guard(
        () => http.get(
              url,
              headers: {
                HttpHeaders.authorizationHeader:
                    'BM ${ref.read(sharedPreferencesProvider).getString("access")}',
              },
            ),
        ref);

    return mechanicsFromJson(response);
  }
}
