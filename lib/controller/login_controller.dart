import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/view/screens/home_screen.dart';
import 'package:donate_blood/view/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../view/widgets/custom_snackbar.dart';
import '../model/user_information.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isChecked = false.obs;
  var obscureText = true.obs;
  var isLoading= false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> _firebaseUser = Rx<User?>(null);

  String? errorMessage;
  void toggleObscureText() {
    obscureText.value = !obscureText.value;
    update();
  }
  @override
  void onInit() {
    super.onInit();
    // Listen to Firebase user changes
    _auth.authStateChanges().listen((User? user) {
      _firebaseUser.value = user;
    });
  }

  // Getter for Firebase user
  User? get firebaseUser => _firebaseUser.value;

  // Login method
  Future<void> login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      errorMessage = null;
      emailController.text = '';
      passwordController.text = '';

      // Get the user's ID
      token = userCredential.user!.uid;

      // Get the user's information from Firestore
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance.collection('usersInformation').doc(token).get();

      if (documentSnapshot.exists) {
        final userData = UserInformation.fromMap(documentSnapshot.data()!);

        if (userData.status == "approved") {
          // User has been approved, navigate to HomeScreen
          CustomSnackbar('Success', 'Login successful', isSuccess: true);
          Get.to(() => HomeScreen());
        } else if (userData.status == "pending") {
          // User is still pending review, show a message
          CustomSnackbarInfo('Info', 'Your account is pending review plz try in other time');
        } else {
          // User has been rejected, show a message
          CustomSnackbar('Error', 'Your account has been rejected');
        }
      } else {
        // User has no information in Firestore, show a message
        CustomSnackbar('Error', 'No user information found');
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = e.message;
      }
      CustomSnackbar('Error', errorMessage!);
    } catch (e) {
      CustomSnackbar('Error', e.toString());
      errorMessage = e.toString();
    }

    update();
  }
  void resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      CustomSnackbar('Password Reset Email Sent', 'Check your email for instructions',isSuccess: true);

    } on FirebaseAuthException catch (e) {
      CustomSnackbar('Error Sending Password Reset Email', e.toString());

    }
  }
// Logout method

}