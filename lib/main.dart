// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, library_private_types_in_public_api

import 'package:finology/bloc/app_cubit.dart';
import 'package:finology/screen/home.dart';
import 'package:finology/screen/intro_screen/introduction.dart';
import 'package:finology/screen/intro_screen/spash_screen.dart';
import 'package:finology/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Constance/constance.dart' as constance;
import 'Constance/constance.dart';
import 'Constance/theme.dart';
import 'screen/auth_screen/login.dart';
import 'screen/auth_screen/infodata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(BlocProvider(
      create: (_)=>AppCubit()..getDateUser()..getPlans(),
  child: MyApp(),)));
}

class MyApp extends StatefulWidget {
  static setCustomeTheme(BuildContext context, int index) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setCustomeTheme(index);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  setCustomeTheme(int index) {
    if (index == 6) {
      setState(() {
        AppTheme.isLightTheme = true;
      });
    } else if (index == 7) {
      setState(() {
        AppTheme.isLightTheme = false;
      });
    } else {
      setState(() {
        constance.colorsIndex = index;
        constance.primaryColorString =
            ConstanceData().colors[constance.colorsIndex];
        constance.secondaryColorString = constance.primaryColorString;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1)).then(
        (value) => SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:
                  AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
              statusBarBrightness:
                  AppTheme.isLightTheme ? Brightness.light : Brightness.dark,
              systemNavigationBarColor: Colors.black,
              systemNavigationBarDividerColor: Colors.grey,
              systemNavigationBarIconBrightness:
                  AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
            )));
    return MaterialApp(
      scrollBehavior: ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      navigatorKey: GlobalKey<NavigatorState>(),
      theme: AppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }

  var routes = <String, WidgetBuilder>{
    Routes.sPLASH: (BuildContext context) => SplashScreen(),
    Routes.lOGIN: (BuildContext context) => LoginScreen(),
    Routes.infoData: (BuildContext context) => InfoDataScreen(),
    Routes.introduction: (BuildContext context) => IntroductionScreen(),
    Routes.costomeBottomBar: (BuildContext context) => OpenDrawer(),
    Routes.home: (BuildContext context) => Home(),
  };
}

class Routes {
  static String sPLASH = "/";
  static String lOGIN = "/auth_screen/login";
  static String infoData = "/auth_screen/infoData";
  static String introduction = "/auth_screen/introduction";
  static String costomeBottomBar = "/Home/costome_bottombar";
  static String home = "/Home/home";
}

