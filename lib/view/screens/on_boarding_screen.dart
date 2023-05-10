import 'package:donate_blood/view/screens/started_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/on_boarding_controller.dart';
import '../widgets/colors.dart';
import '../widgets/on_boarding_item_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  final OnBoardingController _controller = Get.put(OnBoardingController());

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller.pageController,
              onPageChanged: (int page) {
                _controller.setCurrentPage(page);
              },
              itemCount: _controller.onBoardingItems.length,
              itemBuilder: (BuildContext context, int index) {
                return OnBoardingItemWidget(
                  item: _controller.onBoardingItems[index],
                );
              },
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _controller.onBoardingItems.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 10,
                      width: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: _controller.currentPage.value == index
                            ? primaryColor
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GetBuilder<OnBoardingController>(
              init: OnBoardingController(),
              builder: (controller) {
                return controller.isLastPage.isTrue
                    ? Positioned(
                        bottom: 37,
                        right: 20,
                        child: IconButton(
                          onPressed: () {
                            //navigate to Signup Screen
                            Get.to(() => StartedScreen());
                          },
                          icon: const Icon(
                            Icons.navigate_next,
                            size: 44,
                            color: primaryColor,
                          ),
                        ),
                      )
                    : Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
