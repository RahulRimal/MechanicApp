// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

enum AuthProviderEnum {
  @JsonValue("bazra")
  BAZRA,

  @JsonValue("google")
  google,
}
