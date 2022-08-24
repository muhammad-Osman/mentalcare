import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/utils.dart';
import 'auth_services.dart';

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
            authService.signUpUser(
                context: context,
                firstName: userCredential.user!.displayName!,
                lastName: userCredential.user!.displayName!,
                dob: "02-08-1990",
                city: "XXX",
                state: "XXX",
                gender: "Male",
                country: "XXX",
                email: userCredential.user!.email!,
                password: "12345678",
                passwordConfirmation: "12345678");
          } else {
            authService.signInGoogle(
                context: context, email: userCredential.user!.email!);
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }
}
