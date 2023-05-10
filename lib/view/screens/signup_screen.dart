import 'package:donate_blood/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/signup_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/colors.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';

class SignupScreen extends StatelessWidget {
  final SignupController _signupController = Get.put(SignupController());
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
                              'img/signup.png',
                              height: 350.0,
                            ),
                            CustomTextField(
                              controller: _signupController.nameController,
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Name',
                              validatorFn: validateName,
                              type: TextInputType.text,
                            ),
                            SizedBox(height: 10,),
                            CustomTextField(
                              controller: _signupController.phoneController,
                              prefixIcon: Icon(Icons.phone),
                              hintText: 'Phone',
                              validatorFn: validatePhone,
                              type: TextInputType.phone,
                            ),
                            SizedBox(height: 10,),
                            CustomTextField(
                              controller: _signupController.emailController,
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Email',
                              validatorFn: validateEmail,
                              type: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 10,),

                            GetBuilder<SignupController>(init: SignupController(),
                              builder: (controller)=>CustomTextField(
                                controller: _signupController.passwordController,
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Password',
                                suffix:controller.obscureText.value? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                suffixFunction: ()=>controller.toggleObscureText(),
                                validatorFn: validatePassword,
                                onPressed: () {},
                                type: TextInputType.visiblePassword,
                                obscureText: controller.obscureText.value,
                              ),),
                            SizedBox(height: 10,),
                            CustomTextField(
                              controller: _signupController.locationController,
                              prefixIcon: Icon(Icons.location_city),
                              hintText: 'Location',
                              validatorFn: validateName,
                            ),

                            SizedBox(height: 12,),
                            DropdownButtonFormField<String>(
                              value: _signupController.selectedTypeGender.value,
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
                                _signupController.selectedTypeGender.value = value!;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Gender Type',
                                icon: Icon(Icons.transgender),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 12,),
                            DropdownButtonFormField<String>(
                              value: _signupController.selectedTypeBlood.value,
                              items: const [
                                DropdownMenuItem(
                                  value: 'O+',
                                  child: Text('O+'),
                                ),
                                DropdownMenuItem(
                                  value: 'O-',
                                  child: Text('O-'),
                                ),
                                DropdownMenuItem(
                                  value: 'A+',
                                  child: Text('A+'),
                                ),
                                DropdownMenuItem(
                                  value: 'A-',
                                  child: Text('A-'),
                                ),
                                DropdownMenuItem(
                                  value: 'B+',
                                  child: Text('B+'),
                                ),
                                DropdownMenuItem(
                                  value: 'B-',
                                  child: Text('B-'),
                                ),
                                DropdownMenuItem(
                                  value: 'AB+',
                                  child: Text('AB+'),
                                ),
                                DropdownMenuItem(
                                  value: 'AB-',
                                  child: Text('AB-'),
                                ),
                              ],
                              onChanged: (value) {
                                _signupController.selectedTypeBlood.value = value!;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Blood Type',
                                icon: Icon(Icons.bloodtype_rounded),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 30,),
                            GetBuilder<SignupController>(
                              init: SignupController(),
                              builder:(controller)=> Column(
                                children: [
                                  CustomButton(
                                    text: 'Sign Up',
                                    sideColor: primaryColor,
                                    primary: primaryColor,
                                    onPressed: () async{
                                      if (keyForm.currentState!.validate()) {
                                        controller.isLoading.value=true;
                                        await controller.register().then((value) {
                                          controller.isLoading.value=false;
                                          //  print(controller.errorMessage);
                                        });
                                      }
                                    }, onPrimary: Colors.white,
                                  ),
                                  controller. isLoading.value
                                      ? Positioned.fill(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                      : Container(
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10,),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => LoginScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                      text: 'Already have an account ?', index: 2),
                                  CustomText(
                                    text: ' Log In',
                                    index: 3,
                                    //    color: primaryTextColor
                                  )
                                ],
                              ),
                            )
                          ])),
                ))));
  }
}