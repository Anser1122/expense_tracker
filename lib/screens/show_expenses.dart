import 'package:expense_tracker_mobile_app/colors.dart';
import 'package:expense_tracker_mobile_app/models/expanseDetails.dart';
import 'package:expense_tracker_mobile_app/models/expanseIdsList.dart';
import 'package:expense_tracker_mobile_app/screens/common/common.dart';
import 'package:expense_tracker_mobile_app/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widgets/expanse_widget.dart';
import 'add_new_expanse.dart';

class ShowExpenses extends StatefulWidget {
  const ShowExpenses({Key? key}) : super(key: key);

  @override
  State<ShowExpenses> createState() => _ShowExpensesState();
}

class _ShowExpensesState extends State<ShowExpenses> {
  Utils utils = Utils();
  List selectList = [
    'Weekly',
    'Yearly',
    'Monthly',
  ];
  String? selectTime;
  var databaseReference = FirebaseDatabase.instance.ref();
  RxBool getData = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // your code here
      Common.expanseDetails.clear();
      Common.expanseIdList.clear();
      getAllExpansesIds();
      //getDataByWeekly();
    });
  }

  getDataByWeekly() async {
    getData.value = false;
    Common.expanseDetails.clear();
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(const Duration(days: 7)); // Start of the current week (Sunday).
    //DateTime endOfWeek = startOfWeek.add(Duration(days: 7)); // End of the current week (Saturday).

    String formattedStartDate = DateFormat('yyyy-MM-dd').format(startOfWeek);
    //String formattedEndDate = DateFormat('yyyy-MM-dd').format(endOfWeek);

    for (int i = 0; i < Common.expanseIdList.length; i++) {
      await databaseReference.child('Expanses').child(Common.expanseIdList[i].createdTime!.toString()).get().then((value) {
        if (value.value != null) {
          Map<String, dynamic> mapData = Map.from(value.value as Map);
          ExpenseDetails expanseDetails = ExpenseDetails.fromJson(Map.from(mapData));
          DateTime databaseDate = DateTime.parse(expanseDetails.date!.toString());

          if (databaseDate.compareTo(startOfWeek) > 0 && databaseDate.compareTo(now) < 0) {
            Common.expanseDetails.add(expanseDetails);
          }
        }
      });
    }
    getData.value = true;

  }

  getDataByMonthly() async {
    getData.value = false;
    Common.expanseDetails.clear();
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(const Duration(days: 30)); // Start of the current week (Sunday).
    //DateTime endOfWeek = startOfWeek.add(Duration(days: 7)); // End of the current week (Saturday).

    String formattedStartDate = DateFormat('yyyy-MM-dd').format(startOfWeek);
    //String formattedEndDate = DateFormat('yyyy-MM-dd').format(endOfWeek);

    for (int i = 0; i < Common.expanseIdList.length; i++) {
      await databaseReference.child('Expanses').child(Common.expanseIdList[i].createdTime!.toString()).get().then((value) {
        if (value.value != null) {
          Map<String, dynamic> mapData = Map.from(value.value as Map);
          ExpenseDetails expanseDetails = ExpenseDetails.fromJson(Map.from(mapData));
          DateTime databaseDate = DateTime.parse(expanseDetails.date!.toString());

          if (databaseDate.compareTo(startOfWeek) > 0 && databaseDate.compareTo(now) < 0) {
            Common.expanseDetails.add(expanseDetails);
          }
        }
      });
    }
    getData.value = true;

  }

  getDataByYearly() async {
    getData.value = false;
    Common.expanseDetails.clear();
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(const Duration(days: 365)); // Start of the current week (Sunday).
    //DateTime endOfWeek = startOfWeek.add(Duration(days: 7)); // End of the current week (Saturday).

    String formattedStartDate = DateFormat('yyyy-MM-dd').format(startOfWeek);
    //String formattedEndDate = DateFormat('yyyy-MM-dd').format(endOfWeek);

    for (int i = 0; i < Common.expanseIdList.length; i++) {
      await databaseReference.child('Expanses').child(Common.expanseIdList[i].createdTime!.toString()).get().then((value) {
        if (value.value != null) {
          Map<String, dynamic> mapData = Map.from(value.value as Map);
          ExpenseDetails expanseDetails = ExpenseDetails.fromJson(Map.from(mapData));
          DateTime databaseDate = DateTime.parse(expanseDetails.date!.toString());

          if (databaseDate.compareTo(startOfWeek) > 0 && databaseDate.compareTo(now) < 0) {
            Common.expanseDetails.add(expanseDetails);
          }
        }
      });
    }
    getData.value = true;
    print('Hello World Weekly');

    // Query query =  databaseReference
    //       .orderByChild('date')
    //       .startAt(formattedStartDate)
    //       .endAt(formattedEndDate)
    //       .once();
  }

  getAllExpansesIds() async {
    await databaseReference.child('Users').child(Common.userUid).child('ExpanseList').get().then((value) {
      if (value.value != null) {
        for (var item in value.children) {
          Map<dynamic, dynamic> mapData = Map.from(item.value as Map<dynamic, dynamic>);
          ExpenseIdsList expanseIdsList = ExpenseIdsList.fromJson(Map.from(mapData));
          Common.expanseIdList.add(expanseIdsList);
        }
        getAllExpanses();
      } else {
        getData.value = true;
      }
    });
  }

  Future getAllExpanses() async {
    for (int i = 0; i < Common.expanseIdList.length; i++) {
      await databaseReference.child('Expanses').child(Common.expanseIdList[i].createdTime!.toString()).get().then((value) {
        if (value.value != null) {
          Map<String, dynamic> mapData = Map.from(value.value as Map);
          ExpenseDetails expanseDetails = ExpenseDetails.fromJson(Map.from(mapData));
          Common.expanseDetails.add(expanseDetails);
        }
      });
    }
    getData.value = true;
  }
  List<_SalesData>  weekly = [
    _SalesData('0', 15),
    _SalesData('1', 28),
    _SalesData('2', 34),
    _SalesData('3', 22),
    _SalesData('4', 40),
    _SalesData('5', 10),
    _SalesData('6', 50)
  ];

  List<_SalesData> monthly = [
    _SalesData('1', 25),
    _SalesData('5', 48),
    _SalesData('10', 64),
    _SalesData('15', 82),
    _SalesData('20', 10),
    _SalesData('25', 20),
    _SalesData('30', 40)
  ];

  List<_SalesData> yearly = [
    _SalesData('jan', 15),
    _SalesData('mar', 38),
    _SalesData('may', 54),
    _SalesData('jul', 72),
    _SalesData('aug', 50),
    _SalesData('sep', 20),
    _SalesData('nov', 30)
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: utils.poppinsMediumText('DashBoard', 20.0, AppColors.blackColor, TextAlign.center),
              automaticallyImplyLeading: false,
            ),
            body: Obx(
              () => getData.value == true
                  ? Common.expanseDetails.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                decoration: utils.rectangleBoxWithoutElevation(10.0, Colors.white),
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: selectTime,
                                  hint: utils.poppinsRegularText('Select', 16.0, AppColors.txt2Color, TextAlign.left),
                                  dropdownColor: Colors.white,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 30,
                                  underline: const SizedBox(),
                                  style: const TextStyle(color: Colors.black, fontSize: 14),
                                  onChanged: (newValue) {
                                    // print('ValueChoose:${valueChooseCategory}');
                                    setState(() {
                                      selectTime = newValue.toString();
                                      if (selectTime == 'Weekly') {
                                        getDataByWeekly();
                                      }
                                      if (selectTime == 'Monthly') {
                                        getDataByMonthly();
                                      }
                                      if (selectTime == 'Yearly') {
                                        getDataByYearly();
                                      }
                                    });
                                  },
                                  items: selectList.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: utils.poppinsRegularText(valueItem, 16.0, AppColors.txt2Color, TextAlign.left),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Container(
                                height: 200,
                                child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  tooltipBehavior: TooltipBehavior(enable: true),
                                  series: <ChartSeries<_SalesData, String>>[
                                    LineSeries<_SalesData, String>(
                                      dataSource: passList(),
                                      xValueMapper: (_SalesData sales, _) => sales.year,
                                      yValueMapper: (_SalesData sales, _) => sales.sales,
                                      name: 'Sales',
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: Common.expanseDetails.length,
                                itemBuilder: (context, index) {
                                  return ExpanseWidget(
                                    expanseData: Common.expanseDetails[index],
                                    indexValue: index.toString(),
                                    function: () => deleteExpanse(index, Common.expanseDetails[index].createdTime!.toString()),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: SizedBox(
                                  width: Get.width,
                                  height: 55,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.pinkGradient,
                                        maximumSize: Size.fromWidth(Get.width),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                                    onPressed: () {
                                      Get.to(const AddNewExpanse());
                                    },
                                    child: utils.poppinsRegularText('Add new Expense', 16.0, Colors.white, TextAlign.center),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child:
                                  utils.poppinsSemiBoldText('No Expense Add Yet!', 18.0, AppColors.blackColor, TextAlign.center),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const AddNewExpanse());
                              },
                              child: Container(
                                  height: 150,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(left: 10, right: 10),
                                  decoration: utils.orangePinkGradientDecoration(10.0),
                                  child: utils.poppinsSemiBoldText(
                                      'Clink Here to Add your first expense!', 18.0, Colors.white, TextAlign.center)),
                            )
                          ],
                        )
                  : const Center(
                      child: CircularProgressIndicator(
                      backgroundColor: AppColors.pinkGradient,
                      color: AppColors.purpleGradient,
                    )),
            )));
  }

  List<_SalesData> passList(){
    if(selectTime == 'Weekly'){
      return weekly;
    }else if(selectTime == 'Monthly'){
      return monthly;
    }else{
      return yearly;
    }

  }

  deleteExpanse(index, createdTime) async {
    utils.showLoadingDialog();
    await databaseReference.child('Expanses').child(createdTime).remove().whenComplete(() async {
      await databaseReference
          .child('Users')
          .child(Common.userUid)
          .child('ExpanseList')
          .child(createdTime)
          .remove()
          .whenComplete(() {
        Get.back();
        getData.value = false;
        Common.expanseDetails.clear();
        Common.expanseIdList.clear();
        getAllExpansesIds();

        utils.snackBar('You have delete successfully your expense');
      });
    });
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
