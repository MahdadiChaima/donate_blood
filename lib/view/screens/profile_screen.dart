import 'package:donate_blood/model/user_information.dart';
import 'package:donate_blood/view/screens/home_screen.dart';
import 'package:donate_blood/view/widgets/custom_text.dart';
import 'package:donate_blood/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/profile_controller.dart';
import '../widgets/colors.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(
          init: profileController,
          builder: (_) {
            final user = profileController.user;
            return profileController.user == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () => Get.to(()=>HomeScreen()),
                                    icon: Icon(Icons.home_filled)),
                                IconButton(
                                    onPressed: () =>
                                        Get.to(() => EditProfileScreen()),
                                    icon: Icon(Icons.edit)),
                              ],
                            ),
                          ),
                          Center(
                              child: Container(
                            decoration: BoxDecoration(
                              //color: primaryDarkColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: primaryLightColor,
                                width: 0.5,
                              ),
                            ),
                            width: 120,
                            height: 120,
                            child: Image.asset(
                              'img/profile.png',
                              fit: BoxFit.cover,
                            ),
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              customItemInformation(
                                  "Name:", "${user!.username}"),
                              SizedBox(
                                height: 15,
                              ),
                              customItemInformation(
                                  "Gender:", "${user.gender}"),
                              SizedBox(
                                height: 15,
                              ),
                              customItemInformation(
                                  "Phone Number:", "${user.phoneNumber}"),
                              SizedBox(
                                height: 15,
                              ),
                              customItemInformation(
                                  "Blood Type:", "${user.bloodType}"),
                              SizedBox(
                                height: 15,
                              ),
                              customItemInformation(
                                  "Location:", "${user.location}"),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(onTap:(){profileController.logout();} ,child: customItemInformation(Icons.logout,'         LogOut',isLog: true),)

                            ],
                          )
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}

customItemInformation(var title, String text , {bool isLog = false}) => Container(
      decoration: BoxDecoration(
        color: textFieldCBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: primaryLightColor,
          width: 0.5,
        ),
      ),
      child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Row(
            children: [
              isLog?Icon(title,color: primaryColor,):CustomText(
                index: 3,
                text: title,
                color: primaryColor,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(child: CustomText(index: 3, text: "${text}"))
            ],
          )),
    );
