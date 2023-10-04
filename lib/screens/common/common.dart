import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/expanseDetails.dart';
import '../../models/expanseIdsList.dart';



class Common{

  static RxList<ExpenseDetails> expanseDetails=<ExpenseDetails>[].obs;

  static RxList<ExpenseIdsList> expanseIdList=<ExpenseIdsList>[].obs;

  static String userUid='';



}