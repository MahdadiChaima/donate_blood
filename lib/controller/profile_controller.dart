import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/view/screens/login_screen.dart';
import 'package:donate_blood/view/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user_information.dart';
import '../view/widgets/colors.dart';

class ProfileController extends  GetxController{
  UserInformation? user;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  var selectedTypeBlood = 'A+'.obs;
  var selectedTypeGender = 'Female'.obs;
  TextEditingController locationController = TextEditingController();
  RxBool isLoading=false.obs;


  @override
  void onInit() async {
    super.onInit();
    await getUserInformation();
    nameController.text = user!.username;
    phoneController.text = user!.phoneNumber;
    selectedTypeBlood.value=user!.bloodType;
    locationController.text=user!.location;
    selectedTypeGender.value=user!.gender;

  }

  Future<void> getUserInformation() async {

    final documentSnapshot = await FirebaseFirestore.instance
        .collection('usersInformation')
        .doc(token)
        .get();

    if (documentSnapshot.exists) {
      user = UserInformation.fromMap(documentSnapshot.data()!);
      update();
    }
  }
  Future<void> updateUserInformation(UserInformation updatedUser) async {
    try {
      isLoading.value=true ;
      final userRef =
      FirebaseFirestore.instance.collection('usersInformation').doc(token);
      await userRef.update(updatedUser.toMap());
      getUserInformation(); // refresh the user information after updating
      isLoading.value=false ;
      CustomSnackbar('Success', 'Profile updated successfully',isSuccess: true);
    } catch (e) {
      CustomSnackbar('Error', 'Failed to update profile');
    }
  }
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.to(()=>LoginScreen());
  }
}