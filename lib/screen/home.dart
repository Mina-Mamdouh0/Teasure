import 'package:finology/Widgets/widgets.dart';
import 'package:finology/bloc/app_cubit.dart';
import 'package:finology/bloc/app_state.dart';
import 'package:finology/screen/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finology/Constance/constance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/drawer_widget.dart';
import '../main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double min = 0, max = 100;
double _value = 100.0 ;
  String date =
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';

  @override
  Widget build(BuildContext context) {
    var TextTheme = Theme.of(context).textTheme;
    var MediaQueryWidth = MediaQuery.of(context).size.width;
    var MediaQueryHeight = MediaQuery.of(context).size.height;
    var ColorTheme = Theme.of(context);
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                backgroundColor: Colors.grey.withOpacity(0.1),
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor,
                  leadingWidth: MediaQuery.of(context).size.width / 2,
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  title: const Text("مرحبا",
                      style: TextStyle(color: Colors.white)),
                  actions: const [
                    Padding(
                        padding: EdgeInsets.fromLTRB(defaultPadding - 5,
                            defaultPadding, defaultPadding, defaultPadding),
                        child: AppBarIcons())
                  ],
                ),
                body: ListView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom +
                          defaultPadding),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQueryHeight / 70,
                          right: MediaQueryWidth / 30,
                          left: MediaQueryWidth / 30,
                          bottom: MediaQueryHeight / 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 320,
                                height: 150,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(22.5))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("رصيدك الحالى  ",
                                        style: TextTheme.labelLarge),
                                    const Text("0.00 ر.س  ",
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Text("مدخراتى",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const Text("اختر الخطه لتمكن من رؤيه التفاصيل",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey)),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2.0),
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(22.5))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("15.2223 ر.س ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold)),
                                const Text("المتبقى من كل الخطط 3 ",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                             // height: 290,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:  [
                                  const Text("المبلغ المتبقى",
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  const Text("15.2223 ر.س ",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PartPayment()));

                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 45,
                                            width: 135,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Theme.of(context).secondaryHeaderColor),

                                            ),
                                            child:  Text(
                                              "ادفع جزء من المبلغ",
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: 17

                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 45,
                                          width: 135,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Theme.of(context).secondaryHeaderColor),

                                          ),
                                          child:  Text(
                                            "ادفع المبلغ كامل",
                                            style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: 17

                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              const Text(
                                                "المبلغ المدفوع حتى الان",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16

                                                ),
                                              ),
                                              Text(
                                                "15.2223 ر.س ",
                                                style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontSize: 19,
                                                  fontWeight: FontWeight.bold

                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),

                                        Expanded(
                                          child: Column(
                                            children: const [
                                              Text(
                                                "مبلغ الخطط",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16

                                                ),
                                              ),
                                              Text(
                                                "30,4546 ر.س ",
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold

                                                ),
                                              ),
                                            ],
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                  CupertinoSlider(
                                    min: min,
                                      max: max,
                                      value: _value ,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                      },
                                  ),




                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Text("الاستقطعات",style: TextStyle(fontWeight: FontWeight.bold),),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Center(
                            child: Container(
                              height: 120,
                              width: 335,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                 ),
                              child: Column(
                                children:  [
                                  Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: const [
                                            Text("القسط القادم",style: TextStyle(
                                              color: Colors.grey
                                            ),),
                                            Text("April-5 2023",style: TextStyle(
                                                color: Colors.black
                                            ),),

                                          ],
                                        ),
                                        const SizedBox(
                                          width: 70,
                                        ),
                                         Text(
                                          "2,4546 ر.س ",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold

                                          ),
                                        ),




                                      ],
                                    ),

                                  ),
                                  Container(
                                    height: 40,
                                    width: 275,
                                    child: ElevatedButton(onPressed: (){},
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                                        child: const Text("ادفع المبلغ الان")),
                                  )



                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Center(
                            child: Container(
                              height: 120,
                              width: 335,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children:  [
                                  Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: const [
                                            Text("القسط القادم",style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                            Text("April-5 2023",style: TextStyle(
                                                color: Colors.black
                                            ),),

                                          ],
                                        ),
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          "2,4546 ر.س ",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold

                                          ),
                                        ),




                                      ],
                                    ),

                                  ),
                                  Container(
                                    height: 40,
                                    width: 275,
                                    child: ElevatedButton(onPressed: (){},
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                                        child: const Text("ادفع المبلغ الان")),
                                  )



                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Center(
                            child: Container(
                              height: 120,
                              width: 335,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children:  [
                                  Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: const [
                                            Text("القسط القادم",style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                            Text("April-5 2023",style: TextStyle(
                                                color: Colors.black
                                            ),),

                                          ],
                                        ),
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          "2,4546 ر.س ",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold

                                          ),
                                        ),




                                      ],
                                    ),

                                  ),
                                  Container(
                                    height: 40,
                                    width: 275,
                                    child: ElevatedButton(onPressed: (){},
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                                        child: const Text("ادفع المبلغ الان")),
                                  )



                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Center(
                            child: Container(
                              height: 120,
                              width: 335,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children:  [
                                  Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: const [
                                            Text("القسط القادم",style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                            Text("April-5 2023",style: TextStyle(
                                                color: Colors.black
                                            ),),

                                          ],
                                        ),
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          "2,4546 ر.س ",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold

                                          ),
                                        ),




                                      ],
                                    ),

                                  ),
                                  Container(
                                    height: 40,
                                    width: 275,
                                    child: ElevatedButton(onPressed: (){},
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                                        child: const Text("ادفع المبلغ الان")),
                                  )



                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Center(
                            child: Container(
                              height: 120,
                              width: 335,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children:  [
                                  Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: const [
                                            Text("القسط القادم",style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                            Text("April-5 2023",style: TextStyle(
                                                color: Colors.black
                                            ),),

                                          ],
                                        ),
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          "2,4546 ر.س ",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold

                                          ),
                                        ),




                                      ],
                                    ),

                                  ),
                                  Container(
                                    height: 40,
                                    width: 275,
                                    child: ElevatedButton(onPressed: (){},
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                                        child: const Text("ادفع المبلغ الان")),
                                  )



                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Center(
                            child: Container(
                              height: 120,
                              width: 335,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children:  [
                                  Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: const [
                                            Text("القسط القادم",style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                            Text("April-5 2023",style: TextStyle(
                                                color: Colors.black
                                            ),),

                                          ],
                                        ),
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          "2,4546 ر.س ",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold

                                          ),
                                        ),




                                      ],
                                    ),

                                  ),
                                  Container(
                                    height: 40,
                                    width: 275,
                                    child: ElevatedButton(onPressed: (){},
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                                        child: const Text("ادفع المبلغ الان")),
                                  )



                                ],
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
        listener: (context, state) {});
  }
}
