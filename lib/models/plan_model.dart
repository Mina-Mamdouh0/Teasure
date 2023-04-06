import 'package:cloud_firestore/cloud_firestore.dart';


class PlanModel{
  final String totalMoney;
  final String namePlan;
  final String executionStartTime;
  final String numOfMouth;
  final String moneyOfMouth;
  final String planId;
  final String userCreateId;
  final String remainingMoney;
  final String fishedMoney;
  final String moneyInCurrentMouth;
  final String status;
  final Timestamp createdAt;


  PlanModel({
    required this.status,
    required this.executionStartTime,
    required this.moneyInCurrentMouth,
    required this.remainingMoney,
    required this.moneyOfMouth,
    required this.namePlan,
    required this.numOfMouth,
    required this.planId,
    required this.totalMoney,
    required this.fishedMoney,
    required this.userCreateId,
    required this.createdAt,
  });

  factory PlanModel.formJson(Map<String, dynamic> json,){
    return PlanModel(
      totalMoney: json['TotalMoney'],
      fishedMoney: json['FishedMoney'],
      namePlan:json['NamePlan'],
      remainingMoney: json['RemainingMoney'],
      moneyInCurrentMouth: json['MoneyInCurrentMouth'],
      executionStartTime: json['ExecutionStartTime'],
      status: json['Status'],
      numOfMouth: json['NumOfMouth'],
      moneyOfMouth: json['MoneyOfMouth'],
      userCreateId: json['UserCreateId'],
      planId: json['PlanId'],
      createdAt: json['CreatedAt'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'TotalMoney': totalMoney,
      'NamePlan':namePlan,
      'NumOfMouth':numOfMouth,
      'MoneyOfMouth':moneyOfMouth,
      'UserCreateId':userCreateId,
      'PlanId':planId,
      'CreatedAt': createdAt,
      'RemainingMoney': remainingMoney,
      'MoneyInCurrentMouth': moneyInCurrentMouth,
      'ExecutionStartTime': executionStartTime,
      'Status': status,
      'FishedMoney': fishedMoney,
    };

  }
}