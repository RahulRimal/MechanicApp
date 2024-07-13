import 'package:bato_mechanic/src/features/reviews_and_rating/domain/reviews_and_rating/reviews_and_rating.dart';

import '../../domain/user.dart';
import 'user_repository.dart';

class FakeUserRepository extends UserRepository {
  @override
  Future<User> fetchUserInfo(String userIdx) async {
    await Future.delayed(const Duration(seconds: 1));
    return User.fromJson(
      {
        "idx": "4ebFHe3UfuBLr9WbEroijH",
        "name": "Mechanic User",
        "email": "user@mechanic.com",
        "phone": null,
        "image": null,
        "primary_role": "Mechanic",
        "roles": [],
        "additional_attributes": {
          "vehicle_part": "Engine",
          "vehicle_category": "Car",
        }
      },
    );
  }

  @override
  Future<List<User>> fetchRecommendedMechanics(
      String vehicleCategoryIdx, String serviceIdx) async {
    await Future.delayed(const Duration(seconds: 1));
    return usersFromJson(
      [
        {
          "idx": "4ebFHe3UfuBLr9WbEroijH",
          "name": "Mechanic User",
          "email": "user@mechanic.com",
          "phone": null,
          "image": null,
          "primary_role": "Mechanic",
          "roles": [],
          "additional_attributes": {
            "vehicle_part": "Engine",
            "vehicle_category": "Car",
          }
        },
        {
          "idx": "4ebFHe3UfuBLr9WbEroijH",
          "name": "Mechanic User",
          "email": "user@mechanic.com",
          "phone": null,
          "image": null,
          "primary_role": "Mechanic",
          "roles": [],
          "additional_attributes": {
            "vehicle_part": "Engine",
            "vehicle_category": "Car",
          }
        },
      ],
    );
  }

  @override
  Future<void> changePassword(String oldPass, String newPass) {
    throw UnimplementedError();
  }

  @override
  Future<User> updateProfile(Map<String, dynamic> info) {
    throw UnimplementedError();
  }

  @override
  Future<User> fetchUserInfoByUidx(String uIdx) {
    throw UnimplementedError();
  }
}
