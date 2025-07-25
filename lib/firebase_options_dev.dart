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
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC5PqM_bJYDeQuL9uXR0Jgmx9-0Reo5mI8',
    appId: '1:140625559832:web:cdb793601b75c759035e6d',
    messagingSenderId: '140625559832',
    projectId: 'smart-interview-dev',
    authDomain: 'smart-interview-dev.firebaseapp.com',
    storageBucket: 'smart-interview-dev.firebasestorage.app',
    measurementId: 'G-N29WBDL7K2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB97V8nq8oGZQbLDE2MfGpUr9cYs79hk8Q',
    appId: '1:140625559832:android:f0dd2cde190425d5035e6d',
    messagingSenderId: '140625559832',
    projectId: 'smart-interview-dev',
    storageBucket: 'smart-interview-dev.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArV-kapY9Zd27cS5fYfjH3_zUl-uappP4',
    appId: '1:140625559832:ios:ebdf9cc4998c07eb035e6d',
    messagingSenderId: '140625559832',
    projectId: 'smart-interview-dev',
    storageBucket: 'smart-interview-dev.firebasestorage.app',
    iosClientId:
        '140625559832-0m0u0t12muaks5in2tbk2dmjq2k2vtj7.apps.googleusercontent.com',
    iosBundleId: 'com.ntc.smartInterview.dev',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyArV-kapY9Zd27cS5fYfjH3_zUl-uappP4',
    appId: '1:140625559832:ios:1894927616842934035e6d',
    messagingSenderId: '140625559832',
    projectId: 'smart-interview-dev',
    storageBucket: 'smart-interview-dev.firebasestorage.app',
    iosClientId:
        '140625559832-hn7gn1rnvr2sh128md6rrejd39oet04h.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartInterview',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC5PqM_bJYDeQuL9uXR0Jgmx9-0Reo5mI8',
    appId: '1:140625559832:web:081201f66260ef3d035e6d',
    messagingSenderId: '140625559832',
    projectId: 'smart-interview-dev',
    authDomain: 'smart-interview-dev.firebaseapp.com',
    storageBucket: 'smart-interview-dev.firebasestorage.app',
    measurementId: 'G-QPD94XPHS0',
  );

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
}
