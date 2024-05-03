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
    apiKey: 'AIzaSyD6otdtZIyl7MvvMbywLy3I2n986TJFHWo',
    appId: '1:871782868497:web:4151c0a30386001326b3b0',
    messagingSenderId: '871782868497',
    projectId: 'notifyju2',
    authDomain: 'notifyju2.firebaseapp.com',
    storageBucket: 'notifyju2.appspot.com',
    measurementId: 'G-JTM7DZ4Y9T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZoqS2kDJd1_ot7MDUHFbuZZ3p0Cj_avs',
    appId: '1:871782868497:android:d6662a09fb3d2b0126b3b0',
    messagingSenderId: '871782868497',
    projectId: 'notifyju2',
    storageBucket: 'notifyju2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDK55wAkcggt6OyrWeTLOCpRzOjYTDVgMo',
    appId: '1:871782868497:ios:d7789ce00a61c80d26b3b0',
    messagingSenderId: '871782868497',
    projectId: 'notifyju2',
    storageBucket: 'notifyju2.appspot.com',
    iosBundleId: 'com.example.notifyJu',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDK55wAkcggt6OyrWeTLOCpRzOjYTDVgMo',
    appId: '1:871782868497:ios:d7789ce00a61c80d26b3b0',
    messagingSenderId: '871782868497',
    projectId: 'notifyju2',
    storageBucket: 'notifyju2.appspot.com',
    iosBundleId: 'com.example.notifyJu',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD6otdtZIyl7MvvMbywLy3I2n986TJFHWo',
    appId: '1:871782868497:web:91c6d01d06d2fcbb26b3b0',
    messagingSenderId: '871782868497',
    projectId: 'notifyju2',
    authDomain: 'notifyju2.firebaseapp.com',
    storageBucket: 'notifyju2.appspot.com',
    measurementId: 'G-66D8CSN55C',
  );

}