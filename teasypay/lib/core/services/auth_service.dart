import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io' as io;

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Google Sign-In
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw "Google sign-in cancelled";

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw "Google sign-in failed: ${e.message}";
      }
      throw "Google sign-in failed: $e";
    }
  }

  // Facebook Sign-In (if required)
  // Future<UserCredential> signInWithFacebook() async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.login();
  //     if (result.status == LoginStatus.cancelled) throw "Facebook login cancelled";

  //     final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
  //     return await _firebaseAuth.signInWithCredential(credential);
  //   } catch (e) {
  //     if (e is FirebaseAuthException) {
  //       throw "Facebook login failed: ${e.message}";
  //     }
  //     throw "Facebook login failed: $e";
  //   }
  // }

  // Apple Sign-In (iOS only)
  Future<UserCredential> signInWithApple() async {
    try {
      if (io.Platform.isIOS) {
        final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ]);

        final credential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );

        return await _firebaseAuth.signInWithCredential(credential);
      } else {
        throw "Apple Sign-In is only available on iOS";
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw "Apple login failed: ${e.message}";
      }
      throw "Apple login failed: $e";
    }
  }

  // Email & Password Login
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw "Email sign-in failed: ${e.message}";
      }
      throw "Email sign-in failed: $e";
    }
  }

  // Register with Email & Password
  Future<UserCredential> createUserWithEmailPassword(String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw "Registration failed: ${e.message}";
      }
      throw "Registration failed: $e";
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  // Check if User is signed in
  User? get currentUser => _firebaseAuth.currentUser;
}
