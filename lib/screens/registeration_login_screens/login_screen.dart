import 'package:expense_tracker_mobile_app/screens/common/common.dart';
import 'package:expense_tracker_mobile_app/screens/registeration_login_screens/signUp_screen.dart';
import 'package:expense_tracker_mobile_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import '../home_screen.dart';
import '../show_expenses.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Utils utils = Utils();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool absecureText = true.obs;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
   return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/tracker_bg.jpg'),
                        fit: BoxFit.fill
                    ),
                  ),
                  width: Get.width,
                  child:SizedBox()
              ),
              Container(
                decoration: utils.blurGradientDecoration(),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        width: Get.width,
                        height: 120,
                        child:Row(
                          children: [
                            InkWell(
                                onTap: ()
                                {
                                  Get.back();
                                },
                                child: const Icon(Icons.arrow_back,color: Colors.white,)),
                            const SizedBox(width: 10,),
                            utils.poppinsRegularText('Sign In Account', 16.0, AppColors.whiteColor, TextAlign.left)
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 70,),
                            Image.asset('assets/images/user.png',height: 150,width: 250,color: AppColors.pinkGradient,),
                            const SizedBox(height: 70,),

                            Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child:utils.textFieldWithoutIconWithoutBorder(emailController, 'Email Address', AppColors.txt2Color, TextInputType.emailAddress),
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Obx(() => utils.textFieldWithoutIconWithoutBorderSuffix(
                                  passwordController,
                                  'Create Password',
                                  AppColors.txt2Color,
                                  TextInputType.emailAddress,
                                  Icons.lock,
                                  absecureText.value == true ? 'assets/images/view.svg' : 'assets/images/hide.svg', () {
                                absecureText.value = !absecureText.value;
                              }, absecureText.value)),
                            ),

                            const SizedBox(height: 20,),

                            Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: SizedBox(
                                width: Get.width,
                                height: 55,
                                child:  ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.pinkGradient,
                                      maximumSize: Size.fromWidth(Get.width),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
                                  ,
                                  onPressed: ()
                                  {
                                    loginUser(emailController.text.trim().toString(),passwordController.text.trim().toString());
                                  },
                                  child:
                                  utils.poppinsRegularText('SIGN IN', 16.0, Colors.white, TextAlign.center),),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            InkWell(
                              onTap: ()
                              {
                                Get.to(SignUpScreen());
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  utils.poppinsRegularText('Dont have an Account?', 14.0, AppColors.txt2Color, TextAlign.center),
                                  SizedBox(width: 5,),
                                  utils.poppinsRegularText('Sign Up', 14.0, AppColors.pinkGradient, TextAlign.center)
                                ],
                              ),
                            ),
                            // SizedBox(height: 180,)
                            const Divider(
                              height: 50,
                              color: Colors.white,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
  loginUser(String email, String password)
  async {
    if (email.isEmpty) {
      utils.snackBar('Please enter Valid email');
    }
    else if (password.isEmpty) {
      utils.snackBar('Please enter your password');
    }
    else{
      utils.showLoadingDialog();
      try{
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Common.userUid=FirebaseAuth.instance.currentUser!.uid;
        Get.back();
        utils.snackBar('You are sucessfully Login');
        Get.offAll(const ShowExpenses());
    }on FirebaseAuthException catch (e) {
        //print('HelloWorld');
        Get.back();
        utils.snackBar('Invalid Credentials');
        if (e.code == 'user-not-found') {
          Get.back();
          utils.snackBar('User not found along this email and password');
          print('No user found for that email.');
        }
        else if (e.code == 'wrong-password') {
          Get.back();
          utils.snackBar('You entered the wrong password! Try with the correct password');
          print('Wrong password provided for that user.');
        }
      }

  }
}
}
