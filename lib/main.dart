// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/pages/nav/nav.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/loader_widget.dart';
import 'package:jorney/utils/notify_view.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'services/db_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

  final database = await openDatabase(
    join(await getDatabasesPath(), 'journey.db'),
    onCreate: (db, version) {
      db.execute(
        '''
          CREATE TABLE journeys(journeyId TEXT PRIMARY KEY, userId TEXT, title TEXT, level INTEGER, journeyType TEXT, maxLevel INTEGER, createdAt TEXT, startDate TEXT);
          CREATE TABLE progress(progressId TEXT PRIMARY KEY, journeyId TEXT, progressNo INTEGER, base64Img TEXT, tracked INTEGER, imgUrl TEXT);
        ''',
      );
    },
    version: 1,
  );
  DbService(db: database);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    final colors = AppColors();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: (context, child) {
        return Stack(
          children: [child!, const LoaderWidget(), const NotifyView()],
        );
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(backgroundColor: colors.primaryBg),
        fontFamily: 'SfProDisplay',
      ),
      home: const Nav(),
    );
  }
}
