import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/view/screens/home_screen.dart';
import 'package:donate_blood/view/screens/login_screen.dart';
import 'package:donate_blood/view/screens/on_boarding_screen.dart';
import 'package:donate_blood/view/screens/profile_screen.dart';
import 'package:donate_blood/view/screens/splash_screen.dart';
import 'package:donate_blood/view/screens/started_screen.dart';
import 'package:donate_blood/view/widgets/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseStorage.instance;

  // Run the app
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: primaryColor,
      cardColor: primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: primaryColor), // Set the border color here.
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    ),
    home: SplashScreen(),
  ));
}
