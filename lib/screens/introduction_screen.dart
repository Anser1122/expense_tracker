import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../utils/utils.dart';
import 'login_and_signup_screen.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  RxInt pageViewIndex = 0.obs;
  Utils utils = Utils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
        decoration: utils.gradientDecoration(),
        child: Obx(() => pageView()))

    );
  }
  pageView() {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          if (pageViewIndex.value > 0) {
            pageViewIndex.value = pageViewIndex.value - 1;
          }
        }
        if (details.primaryVelocity! < 0) {
          if (pageViewIndex.value < 2) {
            pageViewIndex.value = pageViewIndex.value + 1;
          }
        }
      },
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Container(
              decoration: utils.gradientDecoration(),
              key: UniqueKey(),
              child: SizedBox(),
              // child: Image(
              //   image: showImage(),
              //   alignment: Alignment.topCenter,
              //   height: Get.height,
              //   width: Get.width,
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          Column(
            children: [
              Expanded(flex: 6,
                  child:
                  Container(
                    child:  AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child:
                      Stack(
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
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              key: UniqueKey(),
                              child: Image(
                                image:showImage(),
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),
                  )
              ),
              Expanded(
                flex: 5,
                child: Container(
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
                              key: UniqueKey(),
                              child: utils.poppinsSemiBoldText(showTitle(), 25.0, AppColors.blackColor, TextAlign.center),
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 5,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: Container(
                              height: Get.height,
                              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                              key: UniqueKey(),
                              child: utils.poppinsMediumText(showDes(), 16.0, AppColors.lightGrey2Color, TextAlign.center),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (pageViewIndex.value < 2) {
                                    pageViewIndex.value = pageViewIndex.value + 1;
                                  } else {
                                    Get.to(() => const LoginAndSignUpScreen());
                                  }
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,

                                    child: utils.poppinsRegularText('Skip', 16.0, AppColors.txt2Color, TextAlign.center)

                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (pageViewIndex.value < 2) {
                                    pageViewIndex.value = pageViewIndex.value + 1;
                                  } else {
                                    Get.to(() => const LoginAndSignUpScreen());
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  //margin: const EdgeInsets.only(left: 80, right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: AppColors.pinkGradient
                                  ),
                                  child: Center(
                                      child: Image.asset('assets/images/right_arrow.png')
                                  ),

                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  showImage() {
    switch (pageViewIndex.value) {
      case 0:
        return  const AssetImage('assets/images/fast_food.png',);
      case 1:
        return const AssetImage('assets/images/transportation.png');
      case 2:
        return const AssetImage('assets/images/entertainment.png');
    }
  }
  showTitle() {
    switch (pageViewIndex.value) {
      case 0:
        return 'Handle Food Expense';
      case 1:
        return 'Handle Transport Expense';
      case 2:
        return 'Handle Entertainment Expense';
    }
  }

  showSubTitle() {
    switch (pageViewIndex.value) {
      case 0:
        return 'Faster & Easier';
      case 1:
        return 'Thanks for choosing';
      case 2:
        return 'Confidence of lodging';
    }
  }

  showDes() {

    switch (pageViewIndex.value) {

      case 0:
        return 'This app designed to help user tracks and\nmanaged their expenses related to\nfood and dining.';
      case 1:
        return 'This app designed to help user tracks and\nmanaged their expenses related to\nTransport.';
      case 2:
        return 'This app designed to help user tracks and\nmanaged their expenses related to\nEntertainment.';
    }
  }

  makeCircle(color) {
    return Container(
      width: 15.0,
      height: 15.0,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
