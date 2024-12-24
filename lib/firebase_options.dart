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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDOipWk-BRQjfaIrOTDtzK9cBD2hg7qQ14',
    appId: '1:564003713634:web:b46ede0d584558acbb173b',
    messagingSenderId: '564003713634',
    projectId: 'orca-base-1e338',
    authDomain: 'orca-base-1e338.firebaseapp.com',
    storageBucket: 'orca-base-1e338.firebasestorage.app',
    measurementId: 'G-J78LJQ142D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCb_uwygkik_5ukJuqt7BW-B0qKVD_3xHw',
    appId: '1:564003713634:android:4e9b94ddbcc21347bb173b',
    messagingSenderId: '564003713634',
    projectId: 'orca-base-1e338',
    storageBucket: 'orca-base-1e338.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlYVnPuZXo1sh_O2t3OfHthohsdOmZMWU',
    appId: '1:564003713634:ios:82972b5a51e9ecebbb173b',
    messagingSenderId: '564003713634',
    projectId: 'orca-base-1e338',
    storageBucket: 'orca-base-1e338.firebasestorage.app',
    iosBundleId: 'com.example.orca',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBlYVnPuZXo1sh_O2t3OfHthohsdOmZMWU',
    appId: '1:564003713634:ios:82972b5a51e9ecebbb173b',
    messagingSenderId: '564003713634',
    projectId: 'orca-base-1e338',
    storageBucket: 'orca-base-1e338.firebasestorage.app',
    iosBundleId: 'com.example.orca',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDOipWk-BRQjfaIrOTDtzK9cBD2hg7qQ14',
    appId: '1:564003713634:web:721738b79b85ba8ebb173b',
    messagingSenderId: '564003713634',
    projectId: 'orca-base-1e338',
    authDomain: 'orca-base-1e338.firebaseapp.com',
    storageBucket: 'orca-base-1e338.firebasestorage.app',
    measurementId: 'G-QJ1Q0366WP',
  );
}