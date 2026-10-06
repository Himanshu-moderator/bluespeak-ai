import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Firebase configuration for the "bluespeak-ai" project.
///
/// These client identifiers are public by design (they ship inside every
/// app/website); access is controlled by Firebase Auth settings and rules,
/// not by hiding them.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'Firebase is only configured for Android and web.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoDlDCFY3XEBL-hiH0nftW8cZxTGbjcT0',
    appId: '1:1093008374969:android:5489b33564a850f2e26f68',
    messagingSenderId: '1093008374969',
    projectId: 'bluespeak-ai',
    storageBucket: 'bluespeak-ai.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyANLJmhCtk_b3IC5WwAqIqFZF9cGyaYAgA',
    appId: '1:1093008374969:web:c2c7155624b39b9ae26f68',
    measurementId: 'G-VVQ2LHYG66',
    messagingSenderId: '1093008374969',
    projectId: 'bluespeak-ai',
    authDomain: 'bluespeak-ai.firebaseapp.com',
    storageBucket: 'bluespeak-ai.firebasestorage.app',
  );
}
