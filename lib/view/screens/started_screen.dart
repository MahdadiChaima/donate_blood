import 'package:donate_blood/view/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_button.dart';
import '../widgets/colors.dart';
import '../widgets/custom_text.dart';
import 'login_screen.dart';
class StartedScreen extends StatelessWidget {
  const StartedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset('img/blood.png', height: 40,width: 40,),
                    const SizedBox(width: 10,),
                     const CustomText(index: 6, text: 'Donate Life',),
                  ],
                ),
                Image.asset('img/Blood donation-bro.png'),
                const CustomText(text: 'Donate Blood, Save Lives',index: 10),
                const SizedBox(height: 60,),
                CustomButton(
                  text: 'LOGIN',
                  onPressed: ()=>Get.to(()=>LoginScreen()),
                  sideColor: primaryColor,
                  primary: primaryColor,
                  onPrimary: Colors.white,
                ),
                CustomButton(
                  text: 'SIGNUP',
                  onPressed: ()=>Get.to(()=>SignupScreen()),
                  sideColor: primaryColor,
                  primary: Colors.white,
                  onPrimary: primaryColor,
                ),

              ],
            ),
          ),
        )
    );
  }
}
