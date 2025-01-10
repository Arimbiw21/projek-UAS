import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return _androidOptions;
    }
    throw UnsupportedError('Platform tidak didukung');
  }

  static const FirebaseOptions _androidOptions = FirebaseOptions(
    apiKey: 'AIzaSyDIsIuS_rnX3Bp6cdlv3f0a9YrLLrWZnuU',
    appId: '1:385915812561:android:b14af8b85116e14a7d23f0',
    messagingSenderId: '385915812561',
    projectId: 'dbaplikasi-28e3b',
    storageBucket: 'dbaplikasi-28e3b.firebasestorage.app',
  );
}
