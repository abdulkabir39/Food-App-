// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'FirebaseOptions are not configured for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyCRhtlhxHXGX9vMAGaWdoy2wiev5pJiQ_8",
    authDomain: "general-app-d7ffc.firebaseapp.com",
    projectId: "general-app-d7ffc",
    storageBucket: "general-app-d7ffc.appspot.com",
    messagingSenderId: "747550843096",
    appId: "1:747550843096:android:b0777022d8f6a9c94137ad",
    // measurementId: "YOUR_MEASUREMENT_ID",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCRhtlhxHXGX9vMAGaWdoy2wiev5pJiQ_8",
    appId: "1:747550843096:android:b0777022d8f6a9c94137ad",
    messagingSenderId: "747550843096",
    projectId: "general-app-d7ffc",
    storageBucket: "general-app-d7ffc.appspot.com",
  );
}
