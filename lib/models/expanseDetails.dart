import 'package:flutter/material.dart';

class ExpenseDetails{

  String? receipt;
  String? description;
  String? category;
  String? amount;
  String? date;
  String? createdTime;


  ExpenseDetails(this.receipt,this.description,this.category,this.amount,this.date,this.createdTime);

  ExpenseDetails.fromJson(Map<String,dynamic>json){
    receipt=json['receipt'];
    description=json['description'];
    category=json['category'];
    amount=json['amount'];
    date=json['dateOfExpanse'];
    createdTime=json['createdTime'];

  }
}