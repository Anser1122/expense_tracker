import 'package:expense_tracker_mobile_app/screens/registeration_login_screens/login_screen.dart';
import 'package:expense_tracker_mobile_app/screens/registeration_login_screens/signUp_screen.dart';
import 'package:expense_tracker_mobile_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';

class LoginAndSignUpScreen extends StatefulWidget {
  const LoginAndSignUpScreen({Key? key}) : super(key: key);

  @override
  State<LoginAndSignUpScreen> createState() => _LoginAndSignUpScreenState();
}

class _LoginAndSignUpScreenState extends State<LoginAndSignUpScreen> {

  Utils utils =Utils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: utils.gradientDecoration(),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child:   Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: Get.height,
                    child: Image.asset('assets/images/circle.png'),
                    // child: Image(
                    //   image:showImage(),
                    //   alignment: Alignment.topCenter,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: Get.height,
                    key: UniqueKey(),
                    child: Image.asset('assets/images/img_4.png',

                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],

              ),),
            Expanded(
              flex: 5,
              child:  Container(
                width: Get.width,
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Card(
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      const Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 2,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            // key: UniqueKey(),
                            child: utils.poppinsSemiBoldText('Welcome to Expense Tracker', 25.0, AppColors.blackColor, TextAlign.center),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: SizedBox(
                            height: Get.height,
                            key: UniqueKey(),
                            child: utils.poppinsMediumText('This app is a digital tool designed to help\nusers monitor and manage their financial \nexpenditures.', 16.0, AppColors.lightGrey2Color, TextAlign.center),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 45,
                                width: 150,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.purpleGradient,
                                      // maximumSize: Size.fromWidth(Get.width),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
                                  ,
                                  onPressed: ()
                                  {
                                    Get.to(const LoginScreen());
                                  },
                                  child:
                                  utils.poppinsRegularText('SIGN IN', 16.0, Colors.white, TextAlign.center),),),
                              const SizedBox(height: 7,),
                              SizedBox(
                                height: 45,
                                width: 150,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.pinkGradient,
                                      // maximumSize: Size.fromWidth(Get.width),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
                                  ,
                                  onPressed: ()
                                  {
                                    Get.to(const SignUpScreen());
                                  },
                                  child:
                                  utils.poppinsRegularText('SIGN UP', 16.0, Colors.white, TextAlign.center),),)
                            ],
                          ))

                    ],
                  ),
                ),
              ),)
          ],
        ),
      ),
    );

  }
}
