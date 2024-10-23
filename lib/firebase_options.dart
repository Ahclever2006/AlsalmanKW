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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqf8S7QEGTfxVMh2Ntch-XEAASB-rMEuM',
    appId: '1:967518290527:android:865abae8572dd14d1811ea',
    messagingSenderId: '967518290527',
    projectId: 'alsalmankw-e3980',
    storageBucket: 'alsalmankw-e3980.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3ZfLBUNEQ34WO_vgSG4CwSmDOffq5_0M',
    appId: '1:967518290527:ios:a94e4782d81f7b0c1811ea',
    messagingSenderId: '967518290527',
    projectId: 'alsalmankw-e3980',
    storageBucket: 'alsalmankw-e3980.appspot.com',
    androidClientId: '967518290527-iip0uuhfdsaaggn4tohpuah9q8jtfjnr.apps.googleusercontent.com',
    iosClientId: '967518290527-elrg80mf9cvbtckq7t1p1b55dctvc8ng.apps.googleusercontent.com',
    iosBundleId: 'com.baramjk.alsalman',
  );
}