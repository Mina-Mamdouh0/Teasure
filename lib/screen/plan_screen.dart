import 'package:finology/Constance/constance.dart';
import 'package:finology/Constance/theme.dart';
import 'package:finology/Widgets/common_button.dart';
import 'package:finology/bloc/app_cubit.dart';
import 'package:finology/bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreatPlanScreen extends StatelessWidget {
   CreatPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              'إنشاء خطة ادخارية',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: 'Tajwal',
                color: AppTheme.lightTheme().primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
            bottom: TabBar(
              labelColor: AppTheme.lightTheme().primaryColor,
              labelStyle: const TextStyle(
                fontFamily: 'Tajwal',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              indicatorColor: AppTheme.lightTheme().primaryColor,
              tabs: const [
                Tab(
                  text: 'مدة الادخار',
                ),
                Tab(
                  text: 'مبلغ الاستقطاع',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              NumOfMouth(),
              MoneyOfMouth(),
            ],
          ),
        ),
      ),
    );
  }
}

class NumOfMouth extends StatelessWidget {
   NumOfMouth({Key? key}) : super(key: key);

  final TextEditingController totalMoneyController=TextEditingController();
  final TextEditingController namePlanController=TextEditingController();
  final TextEditingController datePlanController=TextEditingController();
  final TextEditingController numOfMouthController=TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context, state) {
          var cubit=AppCubit.get(context);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, MediaQuery.of(context).padding.bottom + defaultPadding),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: const BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 30, 0, 0),
                      child: TextFormField(
                        controller: totalMoneyController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.deny(RegExp(r'^0+(?=.)')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            fontFamily: 'Lexend',
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                          hintText: 'إجمالي المبلغ المراد ادخاره',
                          hintStyle: const TextStyle(
                            fontFamily: 'Tajwal',
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 24, 24),
                          prefixIcon: FaIcon(
                            FontAwesomeIcons.moneyBillWave,
                            color: AppTheme.lightTheme().primaryColor,
                            size: 32,
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'من فضلك ادخل المبلغ';
                          }
                          return null;
                        },
                        onChanged: (value){
                          if(value.isNotEmpty&&numOfMouthController.text.isNotEmpty){
                            cubit.changeMoneyOfMouth(totalMoney: totalMoneyController.text,moneyMouth:numOfMouthController.text);
                          }else{
                            cubit.moneyOfMouth=0.0;
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  CustomField(
                      prefixSize: 18,
                      hintText: 'اسم الخطة الادخارية',
                      prefixIconColor: Theme.of(context).primaryColor,
                      controller: namePlanController),
                  const SizedBox(height: 10,),
                  CustomField(
                    readOnly: true,
                      prefixSize: 18,
                      hintText: 'تاريخ بدايه السحب',
                      prefixIconColor: Theme.of(context).primaryColor,
                      controller: datePlanController,
                      onTap: (){
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now().add(const Duration(days: 30)),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100)).then((value){
                          if(value!=null) {
                            datePlanController.text = '${value.year}-${value.month}-${value.day}';
                          }
                        });
                      }),
                  const SizedBox(height: 10,),
                  CustomField(
                      prefixSize: 18,
                      keyboardType: TextInputType.number,
                      hintText: 'عدد شهور الادخار',
                      prefixIconColor: Theme.of(context).primaryColor,
                      controller: numOfMouthController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value){
                        if(value.isNotEmpty&&totalMoneyController.text.isNotEmpty){
                          cubit.changeMoneyOfMouth(moneyMouth: value,totalMoney:  totalMoneyController.text);
                        }else{
                          cubit.moneyOfMouth=0.0;
                        }
                      }),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children:  [
                      const Text(
                        'الاستقطاع الشهري :',
                        style: TextStyle(
                          fontFamily: 'Tajwal',
                          fontSize: 20,
                          fontWeight:
                          FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional
                            .fromSTEB(
                            5, 0, 5, 0),
                        child: Text(
                          '${cubit.moneyOfMouth}ريال  ',
                          style: const TextStyle(
                            fontFamily: 'Tajwal',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  (state is LoadingUploadPlans)?const Center(child: CircularProgressIndicator(),):
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding),
                      child: CustomButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              if(totalMoneyController.text=='0'){
                                Fluttertoast.showToast(msg: 'لا يمكن ان يكون المبلغ بصفر');
                              }else{
                                cubit.uploadPlans(
                                    executionStartTime: datePlanController.text,
                                    namePlan: namePlanController.text,
                                    fishedMoney: ((int.parse(numOfMouthController.text)*cubit.moneyOfMouth)).toString(),
                                    numOfMouth: numOfMouthController.text,
                                    totalMoney: totalMoneyController.text,
                                    moneyOfMouth: cubit.moneyOfMouth.toString());
                              }

                            }
                          },
                          text: 'انشاء')),
                ],
              ),
            ),
          );
        },
        listener: (context, state){
          if(state is SuccessUploadPlans){
             totalMoneyController.clear();
             namePlanController.clear();
             datePlanController.clear();
             numOfMouthController.clear();
             BlocProvider.of<AppCubit>(context).getPlans();
             BlocProvider.of<AppCubit>(context).moneyOfMouth=0.0;
             Fluttertoast.showToast(msg: 'تم انشاء الخطه بنجاح');
             Navigator.pop(context);
          }
        });
  }
}


class MoneyOfMouth extends StatelessWidget {
  MoneyOfMouth({Key? key}) : super(key: key);

  final TextEditingController totalMoneyController=TextEditingController();
  final TextEditingController namePlanController=TextEditingController();
  final TextEditingController datePlanController=TextEditingController();
  final TextEditingController moneyOfMouthController=TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context, state) {
          var cubit=AppCubit.get(context);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, MediaQuery.of(context).padding.bottom + defaultPadding),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: const BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 30, 0, 0),
                      child: TextFormField(
                        controller: totalMoneyController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.deny(RegExp(r'^0+(?=.)')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            fontFamily: 'Lexend',
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                          hintText: 'إجمالي المبلغ المراد ادخاره',
                          hintStyle: const TextStyle(
                            fontFamily: 'Tajwal',
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 24, 24),
                          prefixIcon: FaIcon(
                            FontAwesomeIcons.moneyBillWave,
                            color: AppTheme.lightTheme().primaryColor,
                            size: 32,
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'من فضلك ادخل المبلغ';
                          }
                          return null;
                        },
                        onChanged: (value){
                          if(value.isNotEmpty&&moneyOfMouthController.text.isNotEmpty){
                            cubit.changeNumOfMouth(totalMoney: totalMoneyController.text,numMouth:moneyOfMouthController.text);
                          }else{
                            cubit.numOfMouth=0;
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  CustomField(
                      prefixSize: 18,
                      hintText: 'اسم الخطة الادخارية',
                      prefixIconColor: Theme.of(context).primaryColor,
                      controller: namePlanController),
                  const SizedBox(height: 10,),
                  CustomField(
                      readOnly: true,
                      prefixSize: 18,
                      hintText: 'تاريخ بدايه السحب',
                      prefixIconColor: Theme.of(context).primaryColor,
                      controller: datePlanController,
                      onTap: (){
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now().add(const Duration(days: 30)),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100)).then((value){
                          if(value!=null) {
                            datePlanController.text = '${value.year}-${value.month}-${value.day}';
                          }
                        });
                      }),
                  const SizedBox(height: 10,),
                  CustomField(
                      prefixSize: 18,
                      keyboardType: TextInputType.number,
                      hintText: 'المبلغ المراد ادخاره شهريا',
                      prefixIconColor: Theme.of(context).primaryColor,
                      controller: moneyOfMouthController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value){
                        if(value.isNotEmpty&&totalMoneyController.text.isNotEmpty){
                          cubit.changeNumOfMouth(numMouth: value,totalMoney:totalMoneyController.text);
                        }else{
                          cubit.numOfMouth=0;
                        }
                      }),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children:  [
                      const Text(
                        'فتره الادخار ستكون :',
                        style: TextStyle(
                          fontFamily: 'Tajwal',
                          fontSize: 20,
                          fontWeight:
                          FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional
                            .fromSTEB(
                            5, 0, 5, 0),
                        child: Text(
                          '${cubit.numOfMouth}اشهر  ',
                          style: const TextStyle(
                            fontFamily: 'Tajwal',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  (state is LoadingUploadPlans)?const Center(child: CircularProgressIndicator(),):
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding),
                      child: CustomButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              if(totalMoneyController.text=='0'){
                                Fluttertoast.showToast(msg: 'لا يمكن ان يكون المبلغ بصفر');
                              }else{
                              cubit.uploadPlans(
                                  executionStartTime: datePlanController.text,
                                  namePlan: namePlanController.text,
                                  fishedMoney: ((int.parse(moneyOfMouthController.text)*cubit.numOfMouth)).toString(),
                                  numOfMouth: cubit.numOfMouth.toString(),
                                  totalMoney: totalMoneyController.text,
                                  moneyOfMouth: moneyOfMouthController.text);
                            }}
                          },
                          text: 'انشاء')),
                ],
              ),
            ),
          );
        },
        listener: (context, state){
          if(state is SuccessUploadPlans){
            totalMoneyController.clear();
            namePlanController.clear();
            datePlanController.clear();
            moneyOfMouthController.clear();
            BlocProvider.of<AppCubit>(context).getPlans();
            BlocProvider.of<AppCubit>(context).numOfMouth=0;
            Fluttertoast.showToast(msg: 'تم انشاء الخطه بنجاح');
            Navigator.pop(context);
          }
        });
  }
}

