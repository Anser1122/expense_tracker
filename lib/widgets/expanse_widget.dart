import 'package:expense_tracker_mobile_app/models/expanseDetails.dart';
import 'package:expense_tracker_mobile_app/screens/common/common.dart';
import 'package:expense_tracker_mobile_app/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../screens/add_new_expanse.dart';
import '../screens/show_expenses.dart';

class ExpanseWidget extends StatefulWidget {
  final ExpenseDetails? expanseData;
  final String? indexValue;
  final Function function;

  const ExpanseWidget({Key? key, this.expanseData, this.indexValue, required this.function}) : super(key: key);

  @override
  State<ExpanseWidget> createState() => _ExpanseWidgetState();
}

class _ExpanseWidgetState extends State<ExpanseWidget> {
  Utils utils = Utils();
  var databaseReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 2, left: 5, right: 5),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      height: 180,
      width: Get.width,
      decoration: utils.rectangleBoxForServices(20.0, AppColors.greyServices),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  utils.poppinsSemiBoldText('Amount:', 15.0, AppColors.blackColor, TextAlign.center),
                  SizedBox(
                    width: 5,
                  ),
                  utils.poppinsMediumText('${widget.expanseData!.amount}', 15.0, AppColors.txt2Color, TextAlign.center),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  utils.poppinsSemiBoldText('Date:', 15.0, AppColors.blackColor, TextAlign.center),
                  SizedBox(
                    width: 5,
                  ),
                  utils.poppinsMediumText('${widget.expanseData!.date}', 15.0, AppColors.txt2Color, TextAlign.center),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  utils.poppinsSemiBoldText('Category:', 15.0, AppColors.blackColor, TextAlign.center),
                  SizedBox(
                    width: 5,
                  ),
                  utils.poppinsMediumText('${widget.expanseData!.category}', 15.0, AppColors.txt2Color, TextAlign.center),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purpleGradient,
                            maximumSize: Size.fromWidth(Get.width),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                        onPressed: () {
                          Get.to(AddNewExpanse(expanseDataEdit: widget.expanseData, status: 'edit'));
                        },
                        child: utils.poppinsRegularText('Edit Details', 15.0, Colors.white, TextAlign.center),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.pinkGradient,
                            maximumSize: Size.fromWidth(Get.width),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                        onPressed: () {
                          widget.function();
                        },
                        child: utils.poppinsRegularText('Delete Details', 15.0, Colors.white, TextAlign.center),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
