import 'package:allen/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final googleSignIn = GoogleSignIn();
  Stream<User?> get authChanges => _auth.authStateChanges();

  User? get user => _auth.currentUser;
  Future<bool> signInWithGoogle() async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return false;
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credentials);
      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      res = false;
    }
    return res;
  }

  Future<void> logout() async {
    try {
      if (user != null) {
        await googleSignIn.disconnect();
        FirebaseAuth.instance.signOut();
      }
    } on PlatformException catch (err) {
      // Checks for type PlatformException
      if (err.code == 'sign_out_canceled') {
        // Checks for sign_in_canceled exception
        print(err.toString());
      } else {
        throw err; // Throws PlatformException again because it wasn't the one we wanted
      }
    }
  }
}
