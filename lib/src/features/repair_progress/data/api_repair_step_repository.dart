import 'dart:io';

import 'package:bato_mechanic/src/shared/utils/http/http_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/user_settings.dart';
import '../../../shared/utils/constants/managers/api_values_manager.dart';
import 'repair_step_repository.dart';
import 'package:http/http.dart' as http;

class APIRepairStepRepository implements RepairStepRepository {
  APIRepairStepRepository({required this.ref});

  final Ref ref;

  @override
  Future<dynamic> fetchRepairSteps(String repairStepIdx) async {
    var url = Uri.parse(
        '${RemoteManager.BASE_URI}vehicle-repair/repair_requests/$repairStepIdx/repair_steps');

    return await HttpHelper.guard(
        () => http.get(url, headers: {
              HttpHeaders.authorizationHeader:
                  'BM ${ref.read(sharedPreferencesProvider).getString("access")}',
            }),
        ref);
  }

  @override
  Future updateRepairStepStatus(
      String repairRequestIdx, String repairStepIdx, String status) async {
    var url = Uri.parse(
        '${RemoteManager.BASE_URI}vehicle-repair/repair_requests/$repairRequestIdx/repair_steps/$repairStepIdx/');

    return await HttpHelper.guard(
        () => http.patch(url, body: {
              "status": status
            }, headers: {
              HttpHeaders.authorizationHeader:
                  'BM ${ref.read(sharedPreferencesProvider).getString("access")}',
            }),
        ref);
  }
}
