import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
//import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lkarnet/notifications/notifications.dart';
import 'package:lkarnet/root.dart';
import 'components.dart';
import 'navigator/rout_navigator.dart';
import 'settings/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings();
  await FirebaseAppCheck.instance
      // Your personal reCaptcha public key goes here:
      .activate(
    webRecaptchaSiteKey: '6D035D8A-1A94-4DBD-927D-9A21F4C36730',
  );
  MNotificationModel.initialize();
  Workmanager().initialize(
      MNotificationModel
          .calldispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //var appThemeState = ref.watch(appThemeStateNotifier);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('ar'),
      title: 'حانوتي - لكارني',
      theme: MThemeData.lightThemeData,
      darkTheme: MThemeData.darkThemeData,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Root(),
    );
  }
}
