import 'package:bato_mechanic/src/shared/domain/abstract_user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/enums/auth_provier.dart';
import '../utils/enums/dob_type.dart';

part 'user.freezed.dart';
part 'user.g.dart';

List<User> usersFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => User.fromJson(json)).toList();
}

@freezed
class User extends AbstractUserModel with _$User {
  const factory User({
    required String idx,
    required String name,
    required String? email,
    required String? phone,
    required String? gender,
    required List<String> roles,
    @JsonKey(name: "image") required String? profilePic,
    @JsonKey(name: "dob_type") required DOBType dobType,
    @JsonKey(name: "date_of_birth") required DateTime? dateOfBirth,
    @JsonKey(name: "primary_role") required String? primaryRole,
    @JsonKey(name: "auth_provider") required AuthProviderEnum authProvider,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
