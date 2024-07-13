import 'dart:convert';
import 'dart:io';

import 'package:bato_mechanic/src/shared/providers/user_settings.dart';
import 'package:bato_mechanic/src/shared/utils/http/http_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../utils/constants/managers/api_values_manager.dart';

part 'fcm_repository.g.dart';

class FCMDeviceRepository {
  FCMDeviceRepository({
    required this.ref,
  });

  Ref ref;

  Future<String> _getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceName = '';
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.name;
    }
    return deviceName;
  }

  Future<String> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = '';

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String androidId = androidInfo.id;
      String deviceModel = androidInfo.model;
      String deviceManufacturer = androidInfo.manufacturer;

      // Concatenate relevant device information
      String combinedInfo = androidId + deviceModel + deviceManufacturer;

      // Encode the combined information using base64
      List<int> encodedInfo = utf8.encode(combinedInfo);
      String base64EncodedInfo = base64.encode(encodedInfo);

      // Remove any characters that are not alphanumeric or underscores
      deviceId = base64EncodedInfo.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      String identifierForVendor = iosInfo.identifierForVendor as String;
      String deviceModel = iosInfo.model;

      // Concatenate relevant device information
      String combinedInfo = identifierForVendor + deviceModel;

      // Encode the combined information using base64
      List<int> encodedInfo = utf8.encode(combinedInfo);
      String base64EncodedInfo = base64.encode(encodedInfo);

      // Remove any characters that are not alphanumeric or underscores
      deviceId = base64EncodedInfo.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');
    }

    return deviceId;
  }

  Future<bool> registerNewDevice() async {
    // Registering the device to fcm notifications starts here
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String deviceName = await _getDeviceName();
    String deviceId = await _getDeviceId();
    String fcmToken = await messaging.getToken() as String;

    Map<String, dynamic> deviceData = {
      'name': deviceName,
      'registration_id': fcmToken,
      'device_id': deviceId,
      'active': true,
      'type': Platform.isAndroid ? 'android' : 'ios',
    };

    var url = Uri.parse('${RemoteManager.BASE_URI}autho/devices/');

    await HttpHelper.guard(
        () => http.post(
              url,
              headers: {
                HttpHeaders.authorizationHeader:
                    "BM ${ref.read(sharedPreferencesProvider).getString("access")}",
                "Accept": "application/json; charset=utf-8",

                "Access-Control-Allow-Origin":
                    "*", // Required for CORS support to work
                "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
                HttpHeaders.contentTypeHeader: "application/json",
              },
              body: json.encode(deviceData),
            ),
        ref);

    return true;
  }
}

@riverpod
FCMDeviceRepository fcmDeviceRepository(FcmDeviceRepositoryRef ref) {
  return FCMDeviceRepository(ref: ref);
}
