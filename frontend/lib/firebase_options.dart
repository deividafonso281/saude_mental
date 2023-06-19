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
    apiKey: 'AIzaSyBwNUn9WMd_Dd1NnToNyid8i5ynKNIV-5A',
    appId: '1:294111308206:web:427c965648063954e9003f',
    messagingSenderId: '294111308206',
    projectId: 'saude-mental-6f170',
    authDomain: 'saude-mental-6f170.firebaseapp.com',
    storageBucket: 'saude-mental-6f170.appspot.com',
    measurementId: 'G-6FZGRGGT22',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKew0IGP0fuSS_sPwckuGGIEzknXs3d60',
    appId: '1:294111308206:android:c38cbbbaa8d39733e9003f',
    messagingSenderId: '294111308206',
    projectId: 'saude-mental-6f170',
    storageBucket: 'saude-mental-6f170.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkMP_MDorDZIpykI5WmqHFcAbQvjGRYFQ',
    appId: '1:294111308206:ios:3aa31ba79f2d9794e9003f',
    messagingSenderId: '294111308206',
    projectId: 'saude-mental-6f170',
    storageBucket: 'saude-mental-6f170.appspot.com',
    iosClientId: '294111308206-7951vchq2h64bted88of6uhbgbqdq3mo.apps.googleusercontent.com',
    iosBundleId: 'com.example.frontend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDkMP_MDorDZIpykI5WmqHFcAbQvjGRYFQ',
    appId: '1:294111308206:ios:3aa31ba79f2d9794e9003f',
    messagingSenderId: '294111308206',
    projectId: 'saude-mental-6f170',
    storageBucket: 'saude-mental-6f170.appspot.com',
    iosClientId: '294111308206-7951vchq2h64bted88of6uhbgbqdq3mo.apps.googleusercontent.com',
    iosBundleId: 'com.example.frontend',
  );
}
