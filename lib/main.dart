import 'package:bato_mechanic/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'flavors.dart';
import 'src/shared/application/notification_service.dart';
import 'src/shared/providers/user_settings.dart';

Logger _logger = Logger();

Future<void> _firebaseMessengingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  _logger.i('Handling a background message: ${message.messageId}');
  if (message.notification != null) {
    _logger.d("Message also contained a notification: ${message.notification}");
    NotificationService.showNotification(
      title: message.notification!.title as String,
      body: message.notification!.body as String,
      bigPicture: message.notification!.android?.imageUrl,
      largeIcon: message.notification!.android?.imageUrl,
      payload: message.data,
    );
  }
}

Future<void> mainApp(Flavor flavor) async {
  F.appFlavor = flavor;

  // load env
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  _logger.d("Granted permissions:  ${settings.authorizationStatus}");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _logger.i('Got a message whilst in the foreground!');
    _logger.d("Message data ${message.data}");

    if (message.notification != null) {
      _logger
          .d("Message also contained a notification: ${message.notification}");
      NotificationService.showNotification(
        title: message.notification!.title as String,
        body: message.notification!.body as String,
        bigPicture: message.notification!.android?.imageUrl,
        largeIcon: message.notification!.android?.imageUrl,
        payload: message.data,
      );

      // NotificationService.showBigTextNotification(title: message.notification!.title as String, body: message.notification!.body as String);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessengingBackgroundHandler);
  // This line is to initialize awesome notification so don't delete as it might be used in the future
  await NotificationService.initializeNotification();
  // NotificationService.initialize();

  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences)
      ],
      child: const MyApp(),
    ),
  );
}

// ignore: constant_identifier_names
const SHOW_FAKE = false;
