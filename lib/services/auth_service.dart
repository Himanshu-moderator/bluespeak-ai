import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

/// Thrown for auth failures. [code] is mapped to a message in the user's language
/// by `authErrorText`.
class AuthException implements Exception {
  final String code;

  AuthException(this.code);

  @override
  String toString() => 'AuthException($code)';
}

/// Thin wrapper around Firebase Auth. Accounts are optional: when Firebase is not
/// configured for the current platform every call fails with `unavailable`, and the
/// app is still fully usable as a guest.
class AuthService {
  AuthService._();

  /// Set by `main` once Firebase has been initialised successfully.
  static bool firebaseReady = false;

  static FirebaseAuth get _auth => FirebaseAuth.instance;

  static User? get currentUser => firebaseReady ? _auth.currentUser : null;

  static void _requireReady() {
    if (!firebaseReady) throw AuthException('unavailable');
  }

  static Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _requireReady();
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await credential.user?.updateDisplayName(name.trim());
      await credential.user?.reload();
    } on FirebaseAuthException catch (e) {
      throw AuthException(_codeFor(e));
    }
  }

  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _requireReady();
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(_codeFor(e));
    }
  }

  /// Returns false if the user closed the Google sign-in window.
  static Future<bool> signInWithGoogle() async {
    _requireReady();
    try {
      if (kIsWeb) {
        await _auth.signInWithPopup(GoogleAuthProvider());
        return true;
      }
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return false;
      final googleAuth = await googleUser.authentication;
      await _auth.signInWithCredential(
        GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'popup-closed-by-user' ||
          e.code == 'cancelled-popup-request') {
        return false;
      }
      throw AuthException(_codeFor(e));
    } catch (_) {
      throw AuthException('googleFailed');
    }
  }

  static Future<void> sendPasswordReset(String email) async {
    _requireReady();
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw AuthException(_codeFor(e));
    }
  }

  static Future<void> updateDisplayName(String name) async {
    if (!firebaseReady) return;
    await _auth.currentUser?.updateDisplayName(name.trim());
    await _auth.currentUser?.reload();
  }

  static Future<void> signOut() async {
    if (!firebaseReady) return;
    if (!kIsWeb) {
      await GoogleSignIn().signOut();
    }
    await _auth.signOut();
  }

  static String _codeFor(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'invalidEmail';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'wrongCredentials';
      case 'user-disabled':
        return 'disabled';
      case 'email-already-in-use':
        return 'emailInUse';
      case 'weak-password':
        return 'weakPassword';
      case 'account-exists-with-different-credential':
        return 'differentMethod';
      case 'too-many-requests':
        return 'tooMany';
      case 'network-request-failed':
        return 'network';
      case 'operation-not-allowed':
        return 'notEnabled';
      case 'invalid-api-key':
      case 'api-key-not-valid':
      case 'app-not-authorized':
      case 'configuration-not-found':
      case 'unauthorized-domain':
        return 'unavailable';
      default:
        return 'generic';
    }
  }
}
