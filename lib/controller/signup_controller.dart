import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/user_information.dart';
import '../view/screens/home_screen.dart';
import '../view/screens/login_screen.dart';
import '../view/widgets/colors.dart';
import '../view/widgets/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupController extends GetxController {

  var selectedTypeBlood = 'A+'.obs;
  var selectedTypeGender = 'Female'.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  String? verificationId;
  bool emailVerified = false;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RxBool isLoading = false.obs;
  var obscureText = true.obs;
  void toggleObscureText() {
    obscureText.value = !obscureText.value;
    update();
  }


  Future<void> register() async {
    try {
      isLoading.value = true;

      final String email = emailController.text;
      final String password = passwordController.text;

      // Create a new user account in Firebase
      final UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user information to Firestore with a status of "pending"
      token = userCredential.user!.uid;
      final user = UserInformation(
        uid: token!,
        bloodType: selectedTypeBlood.value,
        phoneNumber: phoneController.text,
        username: nameController.text,
        gender: selectedTypeGender.value,
        location: locationController.text,
        status: "pending",
      );
      await firestore
          .collection('usersInformation')
          .doc(token)
          .set(user.toMap());

      CustomSnackbar(
        'Success',
        'Registration successful, your account is pending review',
        isSuccess: true,
      );
      Get.to(()=>LoginScreen());

      isLoading.value = false;
    } catch (e) {
      CustomSnackbar('Error', e.toString());
      isLoading.value = false;
    }
  }
  Future<void> sendVerificationCode(String email) async {
    try {
      // Check if email already exists in Firestore
      final QuerySnapshot querySnapshot = await firestore
          .collection('usersInformation')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.size > 0) {
        CustomSnackbar('Error', 'Email already exists');
        return;
      }

      // Send verification code to the email
      await auth.verifyPasswordResetCode(email);

      CustomSnackbar(
        'Success',
        'Verification code sent to $email, please check your email',
        isSuccess: true,
      );
    } catch (e) {
      CustomSnackbar('Error', e.toString());
    }
  }

  Future<void> getUserData() async {
    try {
      isLoading.value = true;

      // final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await firestore.collection('users').doc(token).get();

      // if (documentSnapshot.exists) {
      //final userData = UserInformation.fromMap(documentSnapshot.data()!);
      //  print(userData.username);
      // do something with userData
      //}

      isLoading.value = false;
    } catch (e) {
      // CustomSnackbar('Error', e.toString());
      isLoading.value = false;
    }
  }
}