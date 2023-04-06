
import 'package:finology/Constance/constance.dart';
import 'package:finology/Widgets/common_button.dart';
import 'package:finology/bloc/app_cubit.dart';
import 'package:finology/bloc/app_state.dart';
import 'package:finology/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InfoDataScreen extends StatelessWidget {
  InfoDataScreen({Key? key}) : super(key: key);


  final TextEditingController emailController=TextEditingController();
  final TextEditingController nameController=TextEditingController();
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context, state) {
          var cubit=AppCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                    defaultPadding,
                    defaultPadding,
                    defaultPadding,
                    MediaQuery.of(context).padding.bottom + defaultPadding),
                children: [
                  Form(
                    key: fKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height / 8),
                        Text("انشاء حساب", style: Theme.of(context).textTheme.headline5),
                        const SizedBox(height: defaultPadding),
                        CustomField(prefixIcon: Icons.person, hintText: 'الاسم',
                            controller:nameController ),
                        const SizedBox(height: defaultPadding),
                        CustomField(prefixIcon: Icons.email, hintText: 'البريد الالكتروني',
                            controller:emailController ),
                        const SizedBox(height: defaultPadding),
                        Row(
                          children: [
                            Checkbox(
                              value: cubit.isSelected,
                              onChanged: (bool? newValue) {
                                cubit.changeCheckBox(newValue!);
                              },
                            ),
                            Text("لانشاء الحساب يجب الموافقه علي " + " ",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 13)),
                            Flexible(
                                child: Text("الاحكام والشروط",
                                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                        color: Theme.of(context).accentColor,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 13))),
                          ],
                        ),
                        (state is LoadingStoreDataState)?const Center(child: CircularProgressIndicator(),):
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding * 2.2),
                            child: CustomButton(
                                disableButton: cubit.isSelected ? false : true,
                                onPressed: () async{
                                  if (fKey.currentState!.validate()) {
                                    cubit.storeDate(
                                        name: nameController.text,
                                        email: emailController.text,);
                                  }

                                },
                                text: 'انشاء حساب الان')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state){
          if(state is SuccessStoreDataState){
            BlocProvider.of<AppCubit>(context).getDateUser();
          Navigator.pushReplacementNamed(context, Routes.costomeBottomBar);
          }
          else if (state is ErrorStoreDataState){
            Fluttertoast.showToast(msg: 'حاول مره اخري');
          }

        });
  }
}
