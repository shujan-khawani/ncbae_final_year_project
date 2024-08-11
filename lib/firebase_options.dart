// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCNs9Fcm-DZGe9bXGkIZQ-yryEjTG8zVr4',
    appId: '1:505730305011:web:91cee32f08112420e42086',
    messagingSenderId: '505730305011',
    projectId: 'ncbae-portal',
    authDomain: 'ncbae-portal.firebaseapp.com',
    databaseURL: 'https://ncbae-portal-default-rtdb.firebaseio.com',
    storageBucket: 'ncbae-portal.appspot.com',
    measurementId: 'G-J8SFY5YTWW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7fB7nbD-0y-RzxvTTp1aUl1SRR7eggfI',
    appId: '1:505730305011:android:1ba46e49bb4b174ce42086',
    messagingSenderId: '505730305011',
    projectId: 'ncbae-portal',
    databaseURL: 'https://ncbae-portal-default-rtdb.firebaseio.com',
    storageBucket: 'ncbae-portal.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAaRpADCi4aU_7xG7_LyIl2IWPbohGY5EU',
    appId: '1:505730305011:ios:1617f4eccd8b2f14e42086',
    messagingSenderId: '505730305011',
    projectId: 'ncbae-portal',
    databaseURL: 'https://ncbae-portal-default-rtdb.firebaseio.com',
    storageBucket: 'ncbae-portal.appspot.com',
    iosBundleId: 'com.example.ncbae',
  );

}