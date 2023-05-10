import 'package:donate_blood/view/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with SingleGetTickerProviderMixin{
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void onReady() {
    super.onReady();
    _animationController =
    AnimationController(vsync:this , duration: Duration(milliseconds: 1000))
      ..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(_animationController)
      ..addListener(() {
        update();
      });
    _startTimer();
  }

  void _startTimer() async {
    await Future.delayed(Duration(seconds: 3));
    Get.to(()=>OnBoardingScreen());
  }
}
