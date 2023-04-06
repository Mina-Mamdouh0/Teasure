import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpModel{
  final String name;
  final String email;
  final String phone;
  final String uId;
  final String nationalIdentity;
  final String monthlyIncome;
  final String totalMonthlyCommitments;
  final String totalMonthlyExpenses;
  final String profileImage;
  final List plans;
  final Timestamp createdAt;


  SignUpModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.createdAt,
    required this.plans,
    required this.monthlyIncome,
    required this.nationalIdentity,
    required this.totalMonthlyCommitments,
    required this.totalMonthlyExpenses,
    required this.profileImage,
     });

  factory SignUpModel.formJson(Map<String, dynamic> json,){
    return SignUpModel(
      name: json['Name'],
      email:json['Email'],
      phone: json['Phone'],
      uId: json['UId'],
      createdAt: json['CreatedAt'],
      profileImage: json['ProfileImage'],
      totalMonthlyExpenses: json['TotalMonthlyExpenses'],
      totalMonthlyCommitments: json['TotalMonthlyCommitments'],
      nationalIdentity: json['NationalIdentity'],
      monthlyIncome: json['MonthlyIncome'],
      plans: json['Plans'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Name': name,
      'Email':email,
      'Phone': phone,
      'UId': uId,
      'CreatedAt': createdAt,
      'ProfileImage': profileImage,
      'MonthlyIncome': monthlyIncome,
      'Plans': plans,
      'NationalIdentity': nationalIdentity,
      'TotalMonthlyCommitments': totalMonthlyCommitments,
      'TotalMonthlyExpenses': totalMonthlyExpenses,

    };

  }
}