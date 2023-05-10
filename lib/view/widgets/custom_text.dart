import 'package:flutter/material.dart';

import 'colors.dart';
class CustomText extends StatelessWidget {
  final int index;
  final String text;
  final Color? color;
  const CustomText({super.key, required this.index, required this.text,this.color=Colors.black});
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;
    switch (index) {
      case 1://head
        textStyle = TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: color
        );
        break;
      case 2://Subtitle
        textStyle =const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: subTitleTextColor
        );
        break;
      case 3://semiBold
        textStyle = TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: color
        );
        break;



      default:
        textStyle =const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        );
    }
    return Text(
      text,
      style:textStyle,
    );
  }
}
