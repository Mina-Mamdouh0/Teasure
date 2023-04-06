// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, unnecessary_this, use_key_in_widget_constructors, deprecated_member_use, unused_import, non_constant_identifier_names, unused_local_variable, unused_element, library_private_types_in_public_api

import 'dart:developer';
import 'package:animations/animations.dart';
import 'package:finology/Constance/theme.dart';
import 'package:finology/screen/account_screen.dart';
import 'package:finology/screen/home.dart';
import 'package:finology/screen/plan_screen.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:finology/Constance/constance.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'common_button.dart';
import 'drawer_widget.dart';

bool status = AppTheme.isLightTheme ? false : true;
int currentIndex = 0;
List<Widget> currentPage = [
  Home(),
  AccountScreen(),
];

class CostomeBottomBar extends StatefulWidget {
  @override
  _CostomeBottomBarState createState() => _CostomeBottomBarState();
}

class _CostomeBottomBarState extends State<CostomeBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageTransitionSwitcher(
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: currentPage[currentIndex]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(blurRadius: 5,
                  spreadRadius: 2,
                  color: Theme.of(context).disabledColor)
            ],
          ),
          height: MediaQuery.of(context).padding.bottom + 55,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => setState(() => currentIndex = 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          currentIndex == 0
                              ? FontAwesomeIcons.solidListAlt
                              : FontAwesomeIcons.listAlt,
                          color: currentIndex == 0
                              ? AppTheme.isLightTheme
                                  ? Theme.of(context).primaryColor
                                  : blueColor
                              : Theme.of(context).iconTheme.color,
                          size: 23),
                      SizedBox(height: 5),
                      Text("لوحة القيادة",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                fontSize: 13,
                                color: currentIndex == 0
                                    ? AppTheme.isLightTheme
                                        ? Theme.of(context).primaryColor
                                        : blueColor
                                    : Theme.of(context).iconTheme.color,
                              )),
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: () => setState(() => currentIndex = 1),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          currentIndex == 1
                              ? Icons.account_balance_rounded
                              : Icons.account_balance_outlined,
                          color: currentIndex == 1
                              ? AppTheme.isLightTheme
                                  ? Theme.of(context).primaryColor
                                  : blueColor
                              : Theme.of(context).iconTheme.color,
                          size: 24),
                      SizedBox(height: 5),
                      Text("حسابى",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                fontSize: 13,
                                color: currentIndex == 1
                                    ? AppTheme.isLightTheme
                                        ? Theme.of(context).primaryColor
                                        : blueColor
                                    : Theme.of(context).iconTheme.color,
                              )),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton:FloatingActionButton(
          backgroundColor: blueColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=>CreatPlanScreen()));
          },
          child: Icon(Icons.add),

        )
      );
  }
}

