import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final splashController=Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(  height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD91106), Color(0xFFB22222)],
        ),
      ),
        child: Center(child: Column(
          children: [
            SizedBox(height: 80),
            Image.asset('img/logo.png',height: 279,width: 221,),
            Image.asset('img/donate text.png',width: 201,),
          ],
        ),),
      ),
    );
  }
}
