import 'package:donate_blood/view/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/login_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/colors.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
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
                              'img/Login.png',
                              height: 350.0,
                            ),
                            CustomTextField(
                              controller: _loginController.emailController,
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Email',
                              validatorFn: validateEmail,
                              onPressed: () {},
                              type: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 10,),
                            GetBuilder<LoginController>(init: LoginController(),
                              builder: (controller)=>CustomTextField(
                                controller: _loginController.passwordController,
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
                            SizedBox(height: 5,),
                            Align(alignment: Alignment.topLeft,
                              child: GetBuilder<LoginController>(
                                init: LoginController(),
                                builder:(controller)=> GestureDetector(
                                  onTap: (){
                                    controller.resetPassword();
                                  },
                                  child: CustomText(
                                      text: 'Forget Password ? ',
                                      index: 7),
                                ),
                              ),
                            ),
                            SizedBox(height: 40,),
                            GetBuilder<LoginController>(
                              init: LoginController(),
                              builder:(controller)=> Column(
                                children: [
                                  CustomButton(
                                      text: 'Login',
                                      sideColor: primaryColor,
                                      primary: primaryColor,
                                      onPressed: () async{
                                        if (keyForm.currentState!.validate()) {
                                          controller.isLoading.value=true;
                                          await controller.login().then((value) {
                                            controller.isLoading.value=false;
                                            print(controller.errorMessage);});
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
                                Get.to(() => SignupScreen());
                                 },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                      text: 'Don’t have an account yet ?', index: 2),
                                  CustomText(
                                      text: ' Register',
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