// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const defaultRadius = 12.0;
const defaultPadding = 15.0;
const blueColor = Color(0xff1ab1dc);
const redColor = Color(0xfff1323a);
const greenColor = Color(0xff3ad5b6);

ColorThemes(BuildContext context) {
  Theme.of(context);
}

TextThemes(BuildContext context) {
  Theme.of(context).textTheme;
}

Size displaySize(BuildContext context) {
  debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

showToast(String? message) => Fluttertoast.showToast(
    msg: message.toString(),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 10,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0);

class ConstanceData {
  static String bseImageUrl = 'assets/images/';
  static String splashBg = bseImageUrl + "splash_bg.png";
  static String loginBg = bseImageUrl + "login_bg.jpg";
  static String investCard1 = bseImageUrl + "invest_card (1).jpg";
  static String investCard2 = bseImageUrl + "invest_card (2).jpg";
  static String investCard3 = bseImageUrl + "invest_card (3).jpg";
  static String investCard4 = bseImageUrl + "invest_card (4).jpg";
  static String cardBackground = bseImageUrl + "cardBackgroundImage.jpg";
  static String bankLogo = bseImageUrl + "bank_logo.png";
  static String cashBack = bseImageUrl + "cash_back.png";
  static String creditCard = bseImageUrl + "credit_card.png";
  static String blueChart = bseImageUrl + "blue_chart.jpg";
  static String chart = bseImageUrl + "chart.jpg";

  ////////////////////////////////////////////
  static String bseIconUrl = 'assets/icons/';
  static String claylogo = bseIconUrl + "treasure-background.png";
  static String googleIcon = bseIconUrl + "google_icon.png";
  static String facebookFIcon = bseIconUrl + "facebook_f_icon.png";
  static String appleIcon = bseIconUrl + "apple_icon.png";
  static String youtubeIcon = bseIconUrl + "youtube_icon.png";
  static String netfilixIcon = bseIconUrl + "netflix_icon.png";
  static String mutualFunds = bseIconUrl + "mutual_funds.png";
  static String equitiesIcon = bseIconUrl + "equities_icon.png";
  static String upAndDownArrow = bseIconUrl + "upanddown_arrow.png";
  static String treaBackground = bseImageUrl + "clay-logo.png";
  ////////////////////////////////////////////

  static String bseJsonUrl = "assets/jsonImage/";
  static String securityScanningJson =
      bseJsonUrl + "Security Scanning Lottie.json";
  static String manageMoneyJson = bseJsonUrl + "Manage Money.json";
  static String investJson = bseJsonUrl + "Invest.json";
  static String financialFreedomJson = bseJsonUrl + "Financial Freedom.json";
  static String chartJson = bseJsonUrl + "chart.json";

  List<String> colors = [
    '#f4651f',
    '#FF2222',
    '#32a852',
    '#4C4CFF',
    '#B323BA',
    '#4FBE9F'
  ];
}

int colorsIndex = 0;

var primaryColorString = '#3054cf';
var secondaryColorString = '#0ab7e4';
