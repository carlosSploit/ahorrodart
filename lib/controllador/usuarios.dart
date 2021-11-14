import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UsuariosController extends GetxController {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user!;
      Get.snackbar("Login", '${user.email} signed in');
    } catch (e) {
      Get.snackbar(
          "error al logiarme", 'Failed to sign in with Email & Password');
    }
  }

  void _singOunt() async {
    await _auth.signOut();
  }

  void SignOut() async {
    final User user = await _auth.currentUser as User;
    if (user == null) {
      Get.snackbar("Out", 'No one has signed in.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    _singOunt();
    final String uid = user.uid;
    Get.snackbar("Out", uid + 'has succes signed out',
        snackPosition: SnackPosition.BOTTOM);
  }

  //Example code of how to sign in with Google.
  static Future<bool> signInWithGoogle() async {
    final FirebaseAuth _auth2 = FirebaseAuth.instance;
    try {
      UserCredential userCredential;

      final GoogleSignInAccount googleUser =
          await GoogleSignIn().signIn() as GoogleSignInAccount;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);

      final User user = userCredential.user as User;

      Get.snackbar("Login", 'Sign In ${user.uid} with Google');
      return true;
    } catch (e) {
      Get.snackbar("error al logiarme", 'Failed to sign in with Google: $e');
      print(e);
      return false;
    }
  }
}
