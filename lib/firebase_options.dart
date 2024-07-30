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
    apiKey: 'AIzaSyDIbXDIInAwCTA5fEaJQCWEvb7SDV_gHHE',
    appId: '1:352012747932:web:71fbac236a8f9f0a045959',
    messagingSenderId: '352012747932',
    projectId: 'flutter-comment',
    authDomain: 'flutter-comment.firebaseapp.com',
    storageBucket: 'flutter-comment.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXDfQ6ktsjG3L7_ljAovnzPvwX_xQ_I28',
    appId: '1:352012747932:android:1b59b2f8680cc0c1045959',
    messagingSenderId: '352012747932',
    projectId: 'flutter-comment',
    storageBucket: 'flutter-comment.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjKqtGWujr8MiMR39b23NixPmN2hKV3j8',
    appId: '1:352012747932:ios:b85e28b8e5516e91045959',
    messagingSenderId: '352012747932',
    projectId: 'flutter-comment',
    storageBucket: 'flutter-comment.appspot.com',
    iosBundleId: 'com.example.flutterComment',
  );
}
