import 'package:flutter/material.dart';
import '../../model/on_boarding_item_model.dart';
import 'custom_text.dart';

class OnBoardingItemWidget extends StatelessWidget {
  final OnBoardingItem item;
  const OnBoardingItemWidget({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.59,
            width: screenWidth,
            child: Image.asset(
              item.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomText(
              text: item.title,
              index: 1,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomText(
              text: item.subTitle,
              index: 2,
            ),
          ),
        ],
      ),
    );
  }
}
