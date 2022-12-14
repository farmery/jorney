// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBes24-bZ-trvX1UUAACGVsEYjHsZTu7lo',
    appId: '1:275329932653:web:c29c2445dc1a47e9b64e64',
    messagingSenderId: '275329932653',
    projectId: 'jorney-4c011',
    authDomain: 'jorney-4c011.firebaseapp.com',
    storageBucket: 'jorney-4c011.appspot.com',
    measurementId: 'G-C6RCVES43M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBq3r_t4BXNIXeCSEILBQEuDGSmIFc7utY',
    appId: '1:275329932653:android:9a41efe47f536cadb64e64',
    messagingSenderId: '275329932653',
    projectId: 'jorney-4c011',
    storageBucket: 'jorney-4c011.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChUdxiYcyJs8EpQlZzXpQ8quCH3UoCF5o',
    appId: '1:275329932653:ios:75dccec319702431b64e64',
    messagingSenderId: '275329932653',
    projectId: 'jorney-4c011',
    storageBucket: 'jorney-4c011.appspot.com',
    iosClientId: '275329932653-q0smc405n8bc1ctrnrduappembv76i66.apps.googleusercontent.com',
    iosBundleId: 'com.example.jorney',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChUdxiYcyJs8EpQlZzXpQ8quCH3UoCF5o',
    appId: '1:275329932653:ios:75dccec319702431b64e64',
    messagingSenderId: '275329932653',
    projectId: 'jorney-4c011',
    storageBucket: 'jorney-4c011.appspot.com',
    iosClientId: '275329932653-q0smc405n8bc1ctrnrduappembv76i66.apps.googleusercontent.com',
    iosBundleId: 'com.example.jorney',
  );
}
