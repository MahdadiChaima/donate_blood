import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/profile_controller.dart';
import '../../model/user_information.dart';
import '../widgets/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  final profileController = Get.put(ProfileController());
  var keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Form(
                  key: keyForm,
                  child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Image.asset(
                          'img/update.png',
                          height: 350.0,
                        ),
                        CustomTextField(
                          controller: profileController.nameController,
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Name',
                          validatorFn: validateName,
                          type: TextInputType.text,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: profileController.phoneController,
                          prefixIcon: Icon(Icons.phone),
                          hintText: 'Phone',
                          validatorFn: validatePhone,
                          type: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: profileController.locationController,
                          prefixIcon: Icon(Icons.location_city),
                          hintText: 'Location',
                          validatorFn: validateName,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        DropdownButtonFormField<String>(
                          value: profileController.selectedTypeGender.value,
                          items: const [
                            DropdownMenuItem(
                              value: 'Male',
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: 'Female',
                              child: Text('Female'),
                            ),
                          ],
                          onChanged: (value) {
                            profileController.selectedTypeGender.value = value!;
                          },
                          decoration:  InputDecoration(
                            labelText: 'Gender Type',
                            icon: Icon(Icons.transgender),
                            border: OutlineInputBorder(),
                          ),
                        ),

                        SizedBox(
                          height: 80,
                        ),
                        GetBuilder<ProfileController>(
                          init: ProfileController(),
                          builder: (controller) => Column(
                            children: [
                              CustomButton(
                                text: 'Update Profile',
                                sideColor: primaryColor,
                                primary: primaryColor,
                                onPressed: () async {
                                  final updatedUser = UserInformation(
                                      uid: token!,
                                      username: controller.nameController.text,
                                      phoneNumber:
                                          controller.phoneController.text,
                                      bloodType:
                                          controller.selectedTypeBlood.value,
                                      gender:
                                          controller.selectedTypeGender.value,
                                      location:
                                          controller.locationController.text,status: "approved");
                                  if (keyForm.currentState!.validate()) {
                                    await controller
                                        .updateUserInformation(updatedUser)
                                        .then((value) {
                                      Navigator.pop(context);
                                      //  print(controller.errorMessage);
                                    });
                                  }
                                },
                                onPrimary: Colors.white,
                              ),
                              controller.isLoading.value
                                  ? Positioned.fill(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ])),
                ))));
  }
}
