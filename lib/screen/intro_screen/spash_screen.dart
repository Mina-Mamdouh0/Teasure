// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finology/Constance/constance.dart';
import 'package:finology/bloc/app_cubit.dart';
import 'package:finology/main.dart';
import 'package:finology/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2800),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
    _loadNextScreen();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late BuildContext myContext;
  _loadNextScreen() async {
    await Future.delayed(Duration(milliseconds: 3000));
    if (!mounted) return;
    if(FirebaseAuth.instance.currentUser!=null){
      FirebaseFirestore.instance.collection('Users').get().then((value){
        if(value.docs.any((element)=>element.id==FirebaseAuth.instance.currentUser!.uid)){
          Navigator.pushReplacementNamed(context, Routes.costomeBottomBar);
        }else{
          Navigator.pushReplacementNamed(context, Routes.infoData);
        }
      });
    }
    else{
      SharedPreferences preferences=await SharedPreferences.getInstance();
      if(preferences.getBool('isShow')??false){
        Navigator.pushReplacementNamed(context, Routes.lOGIN);
      }else{
        Navigator.pushReplacementNamed(context, Routes.introduction);
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(ConstanceData.splashBg),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ConstanceData.claylogo, height: 60),
            SizedBox(height: defaultPadding),
            Text(
              "Treasure",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white, fontSize: 35),
            ),
            SizedBox(height: defaultPadding),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding * 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(defaultRadius),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white38,
                  value: controller.value,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
