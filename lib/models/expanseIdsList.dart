import 'package:flutter/material.dart';

class ExpenseIdsList{

  String? createdTime;
  ExpenseIdsList(this.createdTime);

  ExpenseIdsList.fromJson(Map<String,dynamic>json){
    createdTime=json['createdTime'];
  }
}