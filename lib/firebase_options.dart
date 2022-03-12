// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCWG5r-H9_pvKGzdbQIWa9ti1huAecwA6U',
    appId: '1:700205260470:web:5efec7c7d65ed86ef21017',
    messagingSenderId: '700205260470',
    projectId: 'flutterauth-54f6b',
    authDomain: 'flutterauth-54f6b.firebaseapp.com',
    storageBucket: 'flutterauth-54f6b.appspot.com',
    measurementId: 'G-SS6FZVNZPQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVhB00dtbpM3zTz1smWXe8hUxJiPkK8CA',
    appId: '1:700205260470:android:511e97216b8dfa48f21017',
    messagingSenderId: '700205260470',
    projectId: 'flutterauth-54f6b',
    storageBucket: 'flutterauth-54f6b.appspot.com',
  );
}
