import 'dart:async';

import 'package:expense_tracker_mobile_app/screens/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation1 = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );


  Timer? timer;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer(const Duration(seconds: 3), () async {
      Get.offAll(const IntroductionScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
  decoration:  const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:[
            AppColors.purpleGradient,
            AppColors.pinkGradient,
          ])
  ),
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RotationTransition(
          turns: _animation1,
          child: Image.asset('assets/images/logo_no_background.png',height: 200,width: 200,color: Colors.white,),
          // child: Image.asset(
          //   "assets/images/logo.jpeg",
          //   height: 250,
          //   width: 250,
          // ),
        ),
        // SvgPicture.asset(
        //   "assets/images/delivery.svg",
        //   height: 50,
        //   width: 50,
        // ),
      ],
    ),
  ),
),
    );
  }
}
