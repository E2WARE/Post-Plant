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
    apiKey: 'AIzaSyAPYcaHUBAQ610lVN58I2GVgwRoeu7KnPI',
    appId: '1:21562823767:web:0d611df5b91d658845bf12',
    messagingSenderId: '21562823767',
    projectId: 'postplant-lineup',
    authDomain: 'postplant-lineup.firebaseapp.com',
    storageBucket: 'postplant-lineup.appspot.com',
    measurementId: 'G-KF9ZD8LJ89',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBuwszzc-1Ar_wuBUQjBJV1VM8x5yFnLw',
    appId: '1:21562823767:android:07763a95daba489745bf12',
    messagingSenderId: '21562823767',
    projectId: 'postplant-lineup',
    storageBucket: 'postplant-lineup.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgFlPrLR0DGhy6e_6avu2Ba-SxcMaQeGk',
    appId: '1:21562823767:ios:dabcf30233a7439445bf12',
    messagingSenderId: '21562823767',
    projectId: 'postplant-lineup',
    storageBucket: 'postplant-lineup.appspot.com',
    iosBundleId: 'com.example.postplantlineup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgFlPrLR0DGhy6e_6avu2Ba-SxcMaQeGk',
    appId: '1:21562823767:ios:4c5686956e35ff5245bf12',
    messagingSenderId: '21562823767',
    projectId: 'postplant-lineup',
    storageBucket: 'postplant-lineup.appspot.com',
    iosBundleId: 'com.example.postplantlineup.RunnerTests',
  );
}
