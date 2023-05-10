import 'package:flutter/material.dart';

import 'colors.dart';
import 'custom_text.dart';

class CustomContainer extends StatelessWidget {

  final String title,path;
  final VoidCallback onPressed;

   CustomContainer({super.key, required this.title, required this.path,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            //color: primaryDarkColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: primaryLightColor,
              width: 1,
            ),
            color: textFieldCBackgroundColor,
          ),
          height: 120,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(path),
              SizedBox(
                width: 10,
              ),
              CustomText(
                text: title,
                index: 3,
                color: Colors.black87,
              ),
            ],
          ),
        ));
  }
}
