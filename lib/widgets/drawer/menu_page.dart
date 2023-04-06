// ignore_for_file: non_constant_identifier_names, unused_local_variable, library_private_types_in_public_api

import 'dart:developer';
import 'package:finology/Constance/constance.dart';
import 'package:finology/Constance/theme.dart';
import 'package:finology/Widgets/auto_size_text.dart';
import 'package:finology/Widgets/common_button.dart';
import 'package:finology/Widgets/costome_bottombar.dart';
import 'package:finology/Widgets/drawer_widget.dart';
import 'package:finology/bloc/app_cubit.dart';
import 'package:finology/bloc/app_state.dart';
import 'package:finology/screen/edit_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class MenuItem {
  String? title;
  IconData? icon;
  bool selected = false;
  Function()? go;

  MenuItem({
    this.title,
    this.icon,
    this.selected = false,
    this.go
  });
}




bool contentStyle = false;

int light = 1;
int dark = 2;
changeColor(BuildContext context, int color) {
  if (color == light) {
    MyApp.setCustomeTheme(context, 6);
  } else {
    MyApp.setCustomeTheme(context, 7);
  }
}

class MenuScreen extends StatefulWidget {
  final int? index;

  const MenuScreen({this.index, Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {




  @override
  Widget build(BuildContext context) {

    List<MenuItem> menuItemList = <MenuItem>[
      MenuItem(icon: Icons.home, title: "الرئسيه", selected: true,
          go: (){
            setState(() {
              ZoomDrawer.of(context)!.toggle();
            });
          }),
      MenuItem(icon: Icons.account_balance_outlined, title: "حساب",
          go: (){
            setState(() {
              ZoomDrawer.of(context)!.toggle();
            });
          }),
      MenuItem(icon: Icons.check_circle_outlined, title: "الميزانيه",
          go: (){
            setState(() {
              ZoomDrawer.of(context)!.toggle();
            });
          }),
      MenuItem(icon: Icons.person, title: "تعديل الحساب",
          go: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>EditInfoScreen()));
          }),
      MenuItem(icon: Icons.settings_display, title: "Day Night",
          go: (){}),
    ];

    var ColorTheme = Theme.of(context);
    var TextTheme = Theme.of(context).textTheme;
    var MediaQueryWidth = MediaQuery.of(context).size.width;
    var MediaQueryHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit,AppState>
      (builder: (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: AppTheme.isLightTheme
                      ? const LinearGradient(
                    colors: [Color(0xff2884D4), Color(0xff08358B),
                    ],
                  )
                      : LinearGradient(
                    colors: [
                      Colors.grey.shade900,
                      const Color(0xff121315),
                      const Color(0xff121315)
                    ],
                  )),
              height: MediaQuery.of(context).size.height,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * (0.61),
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: defaultPadding,
                              right: defaultPadding,
                              top: MediaQuery.of(context).padding.top + defaultPadding,
                              left: defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SplashIcon(
                                  onPressed: () {
                                    setState(() {
                                      ZoomDrawer.of(context)?.toggle();
                                    });
                                  },
                                  icon: const Icon(Icons.close, color: Colors.white),
                                  size: 28),
                              Row(
                                children: [
                                   Padding(
                                    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                                    child: CircleAvatar(radius: 24,
                                        backgroundImage: NetworkImage(cubit.signUpModel!=null?cubit.signUpModel!.profileImage:'https://media.istockphoto.com/id/1223671392/vector/default-profile-picture-avatar-photo-placeholder-vector-illustration.jpg?s=612x612&w=0&k=20&c=s0aTdmT5aU6b8ot7VKm11DeID6NctRCpB755rA1BIP0=')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: defaultPadding),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(cubit.signUpModel!=null?cubit.signUpModel!.name:'',
                                            style: TextTheme.headline5!.copyWith(
                                                fontSize: 18,
                                                color: Colors.white,
                                                letterSpacing: .5)),
                                        const SizedBox(height: 3),
                                        Text(cubit.signUpModel!=null?cubit.signUpModel!.phone:'',
                                            style: TextTheme.bodyText1!.copyWith(
                                                color: Colors.white, fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text("رصيدك",
                                  style: TextTheme.subtitle2!
                                      .copyWith(fontSize: 12, color: Colors.white70)),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: defaultPadding),
                                  child: Text('0.0',
                                      style: TextTheme.headline5!.copyWith(
                                          fontSize: 27, color: Colors.white))),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Column(
                                children: List.generate(
                                  menuItemList.length,
                                      (index) {
                                    return InkWell(
                                      onTap:  (){
                                        if(index==0||index==1||index==2){
                                          setState(() {
                                            ZoomDrawer.of(context)!.toggle();
                                          });
                                        }
                                        if(index==3){
                                          Navigator.push(context, MaterialPageRoute(builder: (_)=>EditInfoScreen()));
                                        }
                                        //menuItemList[index].go;
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(bottom: 5),
                                        padding: const EdgeInsets.only(
                                            top: defaultPadding - 2,
                                            left: defaultPadding,
                                            right: defaultPadding,
                                            bottom: defaultPadding - 2),
                                        decoration: BoxDecoration(
                                            gradient: menuItemList[index].selected ? AppTheme.isLightTheme
                                                ? LinearGradient(
                                              colors: [
                                                Colors.white.withOpacity(0.3),
                                                Colors.white10.withAlpha(13),
                                                Colors.white10.withAlpha(0)
                                              ],
                                            )
                                                : const LinearGradient(colors: [
                                              Colors.black87,
                                              Colors.transparent
                                            ])
                                                : null),
                                        child: Row(
                                          children: [
                                            Icon(menuItemList[index].icon,
                                                color: Colors.white),
                                            const SizedBox(width: defaultPadding),
                                            AutoSizeText(
                                                menuItemList[index].title.toString(),
                                                maxFontSize: 13,
                                                minFontSize: 12,
                                                style: TextTheme.headline5!
                                                    .copyWith(color: Colors.white)),
                                            if (index == 4)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: defaultPadding),
                                                child: FlutterSwitch(
                                                  height: 22.0,
                                                  width: 33,
                                                  padding: 3.0,
                                                  toggleSize: 15.0,
                                                  activeColor: AppTheme.isLightTheme
                                                      ? AppTheme.isLightTheme
                                                      ? Colors.white
                                                      : Colors.white70
                                                      : Colors.white70,
                                                  toggleColor: AppTheme.isLightTheme
                                                      ? ColorTheme.primaryColor
                                                      : ColorTheme
                                                      .scaffoldBackgroundColor,
                                                  inactiveToggleColor: AppTheme
                                                      .isLightTheme
                                                      ? ColorTheme.primaryColor
                                                      .withOpacity(0.8)
                                                      : ColorTheme
                                                      .scaffoldBackgroundColor,
                                                  inactiveColor: AppTheme.isLightTheme
                                                      ? Colors.white60
                                                      : Colors.grey.withOpacity(0.7),
                                                  borderRadius: defaultRadius,
                                                  value: status,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      status = val;
                                                    });
                                                    if (status == true) {
                                                      changeColor(context, dark);
                                                    } else {
                                                      changeColor(context, light);
                                                    }
                                                  },
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height / 35,
                                    left: defaultPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: OutlinedButton(
                                          onPressed: () {
                                            FirebaseAuth.instance.signOut().whenComplete((){
                                              BlocProvider.of<AppCubit>(context).signUpModel=null;
                                              Navigator.pushReplacementNamed(
                                                  context, Routes.lOGIN);
                                            });
                                          },
                                          style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.white)),
                                          child: const Center(
                                              child: Text(
                                                "تسجيل خروج",
                                                style: TextStyle(color: Colors.white),
                                              ))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
    }, listener: (context,state){});
  }
}
