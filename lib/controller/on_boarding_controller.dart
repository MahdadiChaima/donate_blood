import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/on_boarding_item_model.dart';

class OnBoardingController extends GetxController {
  var currentPage = 0.obs;
  var pageController = PageController(initialPage: 0);
  RxBool isLastPage = false.obs;
  List<OnBoardingItem> onBoardingItems = const [
    OnBoardingItem(
      title: "Give blood, give life",
      subTitle:
      "The act of donating blood is a selfless and noble gesture that can help save lives .",
      imageUrl: "img/Blood donation-rafiki.png",
    ),
    OnBoardingItem(
      title: "Blood donor",
      subTitle:
      "A few minutes of your time can give someone a lifetime.",
      imageUrl: "img/Blood donation-pana.png",
    ),
  ];
  @override
  void onInit() {
    super.onInit();
    currentPage.listen((value) {
      if (value == onBoardingItems.length - 1) {
        isLastPage.value = true;
        print('true');
        update();
      } else {
        isLastPage.value = false;
        print('false');
        update();
      }

    });
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void setCurrentPage(int page) {
    currentPage.value = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOutCirc,
    );

  }
}