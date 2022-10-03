import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentalcaretoday/src/UI/views/sign_up_screen.dart';

import '../utils/utils.dart';
import 'auth_services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FBServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService authService = AuthService();
  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // if you want to do specific task like storing information in firestore
        // only for new users using google sign in (since there are no two options
        // for google sign in and google sign up, only one as of now),
        // do the following:

        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          } else {
            authService.signInGoogle(
                context: context, email: userCredential.user!.email!);
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  } // FACEBOOK SIGN IN

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile']);

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);
      print(userCredential.user?.email);

      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
          );
        } else {
          authService.signInGoogle(
              context: context, email: userCredential.user!.email!);
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }
}
