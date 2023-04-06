
import 'package:animate_do/animate_do.dart';
import 'package:finology/Constance/constance.dart';
import 'package:finology/Widgets/common_button.dart';
import 'package:finology/Widgets/widgets.dart';
import 'package:finology/bloc/app_cubit.dart';
import 'package:finology/bloc/app_state.dart';
import 'package:finology/models/plan_model.dart';
//import 'package:finology/screen/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';


class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(defaultPadding, MediaQuery.of(context).padding.top + defaultPadding, defaultPadding, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("العمليات",
                                style: Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 19)),
                            const Spacer(),
                            const AppBarIcons(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView(
                          padding: EdgeInsets.fromLTRB(0, defaultPadding, 0, MediaQuery.of(context).padding.bottom + defaultPadding * 2.5),
                          children: [
                            Container(
                              height: 180,
                              padding: const EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 40),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: cubit.planList.isEmpty ?
                              Center(child: Text("لا يوجد خطط اتخاريه", style: Theme.of(context).textTheme.headline5),) :
                              ListView.builder(
                                shrinkWrap: true,
                                reverse: true,
                                itemCount: cubit.planList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index){
                                  return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(defaultRadius),
                                        border: Border.all(color: blueColor, width: 1.5),
                                        boxShadow: [BoxShadow(
                                              color: Theme.of(context).disabledColor,
                                              blurRadius: 5,
                                              spreadRadius: 2),],
                                      ),
                                      margin: const EdgeInsets.only(right: defaultPadding, top: 5, left: 3, bottom: 5),
                                      width: 170,
                                      child: Material(
                                          elevation: 0,
                                          borderRadius: BorderRadius.circular(defaultRadius),
                                          color: Theme.of(context).backgroundColor,
                                          child: InkWell(
                                              onTap: () {
                                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>PayPlan(planModel: cubit.planList[index])));
                                              },
                                              borderRadius:
                                              BorderRadius.circular(defaultRadius),
                                              child: Padding(
                                                  padding: const EdgeInsets.only(top: 10, bottom: 3, left: defaultPadding * 1.5, right: defaultPadding * 1.5),
                                                  child:  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      CircleAvatar(
                                                          radius: 23,
                                                          backgroundColor:
                                                          Colors.grey[200],
                                                          child: Center(
                                                              child: BounceInDown(
                                                                  child: Image.asset(ConstanceData.claylogo,
                                                                      height: 28,
                                                                      fit: BoxFit.scaleDown)))),
                                                      const SizedBox(height: defaultPadding + 5),
                                                      Text(cubit
                                                          .planList[index]
                                                          .namePlan
                                                          .toString(),
                                                          style: Theme.of(context).textTheme
                                                              .subtitle2!
                                                              .copyWith(
                                                              fontSize: 12)),
                                                      const SizedBox(height: defaultPadding - 3),
                                                      Row(
                                                        children: [
                                                          Text(cubit.planList[index].totalMoney.toString(),
                                                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                                                  fontSize: 12)),
                                                          const Spacer(),
                                                          Text(cubit.planList[index].status.toString(),
                                                              style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12,color: blueColor)),
                                                        ],
                                                      )
                                                    ],
                                                  ) ))));
                                }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                              child: Column(
                                children: [
                                  Text("العمليات الماليه",
                                      style: Theme.of(context).textTheme.headline5),
                                  //SizedBox(height: defaultPadding),
                                ],
                              ),
                            ),
                          ])),
                ])),
          );
        },
        listener: (context, state) {});
  }
}


