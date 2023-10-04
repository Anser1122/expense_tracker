import 'package:expense_tracker_mobile_app/screens/show_expenses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // backgroundColor: AppColors.whiteColor,
        body:
        Stack(
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
            SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Container(
                width: Get.width,
                decoration: utils.darkBlurGradientDecoration(),
                child: Column(
                  children: [
                    Container(
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //SizedBox(height: 20,)
                            utils.poppinsSemiBoldText('Home DashBoard', 35.0, Colors.white, TextAlign.center)
                          ],
                        ) ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10,bottom:20 ),
                      color: Colors.white,
                      child: Column(
                        children: [
                          const SizedBox(height: 100,),
                          SizedBox(
                              height: 150,
                              child:
                              InkWell(
                                onTap: ()
                                {
                                  Get.to(const ShowExpenses());
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  width: Get.width,
                                  decoration: utils.orangePinkGradientDecoration(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      utils.poppinsMediumText('SHOW EXPENSES', 18.0, AppColors.whiteColor, TextAlign.center)
                                    ],
                                  ),
                                ),
                              )
                          ),
                          SizedBox(
                              height: 150,
                              child:
                              InkWell(
                                onTap: ()
                                {
                                 // Get.to(BusinessServicesDrawer(status:'dashboard'));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: Get.width,
                                  decoration: utils.orangePinkGradientDecoration(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      utils.poppinsMediumText('UPGRADE EXPENSES', 18.0, AppColors.whiteColor, TextAlign.center)
                                    ],
                                  ),
                                ),
                              )
                          ),
                          const SizedBox(height: 100,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
            // Container(
            //   margin: EdgeInsets.only(left: 10,right: 10),
            //   child: Column(
            //     children: [
            //
            //     ],
            //   ),
            // ),
          ],
        )

    );
  }
}
