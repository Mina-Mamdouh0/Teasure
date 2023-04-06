
import 'dart:io';

import 'package:finology/Constance/constance.dart';
import 'package:finology/Constance/theme.dart';
import 'package:finology/Widgets/common_button.dart';
import 'package:finology/bloc/app_cubit.dart';
import 'package:finology/bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditInfoScreen extends StatelessWidget {
   EditInfoScreen({Key? key}) : super(key: key);

  final TextEditingController nameController=TextEditingController();
  final TextEditingController nationalIdentityController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController monthlyIncomeController=TextEditingController();
  final TextEditingController totalMonthlyCommitmentsController=TextEditingController();
  final TextEditingController totalMonthlyExpensesController=TextEditingController();

  final formKey = GlobalKey<FormState>();
  Color selectedPrimaryColor = AppTheme.lightTheme().primaryColor;
  Color selectedSecondedColor = AppTheme.lightTheme().cardColor;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context, state) {
          var cubit=AppCubit.get(context);
         return Directionality(
           textDirection: TextDirection.rtl,
           child: Scaffold(
             body: SingleChildScrollView(
               physics: const BouncingScrollPhysics(),
               padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding,
                   defaultPadding,
                   MediaQuery.of(context).padding.bottom + defaultPadding),
               child: Form(
                 key: formKey,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const SizedBox(height: 20,),
                     Row(
                       mainAxisSize: MainAxisSize.max,
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Card(
                             clipBehavior: Clip.antiAliasWithSaveLayer,
                             color: selectedPrimaryColor,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(20),
                             ),
                             child: RawMaterialButton(
                               fillColor: Colors.transparent,
                               child: Icon(
                                 Icons.close_rounded,
                                 color: selectedSecondedColor,
                                 size: 30,
                               ),
                               onPressed: () async {
                                 Navigator.pop(context);
                               },
                             ))
                       ],
                     ),
                     Align(
                       alignment: Alignment.center,
                       child: Stack(
                         alignment: Alignment.topRight,
                         children: [
                           Container(
                             margin:const  EdgeInsets.all(10),
                             height: MediaQuery.of(context).size.width*0.2,
                             width: MediaQuery.of(context).size.width*0.2,
                             decoration: BoxDecoration(
                               border: Border.all(
                                 color: Colors.white,width: 1,
                               ),
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(10),
                               child: cubit.file==null?Image.network('https://media.istockphoto.com/photos/businessman-silhouette-as-avatar-or-default-profile-picture-picture-id476085198?s=612x612',
                                 fit: BoxFit.fill,):Image.file(cubit.file!,
                                 fit: BoxFit.fill,),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){
                               showDialog(context: context,
                                   builder: (context){
                                     return show(context: context,
                                         camera: ()async{
                                           Navigator.pop(context);
                                           XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                           if(picked !=null){
                                             cubit.changeImage(picked.path);
                                           }
                                         },
                                         gallery: ()async{
                                           Navigator.pop(context);
                                           XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                           if(picked !=null){
                                             cubit.changeImage(picked.path);
                                           }
                                         });
                                   });

                             },
                             child: Container(
                               height: 30,
                               width: 30,
                               decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   border: Border.all(width: 2,
                                       color: Colors.white),
                                   color: Colors.pink
                               ),
                               child: Icon(cubit.file==null?Icons.camera_alt:Icons.edit,
                                 color: Colors.white,
                                 size: 20,),

                             ),
                           )
                         ],
                       ),
                     ),
                     const SizedBox(height: 10,),
                     Text(
                       'اكمل معلومات حسابك الشخصي',
                       textAlign: TextAlign.start,
                       style: TextStyle(
                         fontFamily: 'Tajwal',
                         color: selectedPrimaryColor,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     CustomField(
                         prefixSize: 18,
                         hintText: 'الاسم',
                         prefixIconColor: Theme.of(context).primaryColor,
                         controller: nameController),
                     const SizedBox(height: 10,),
                     CustomField(
                       prefixSize: 18,
                       hintText: 'الهويه الوطنيه',
                       prefixIconColor: Theme.of(context).primaryColor,
                       controller: nationalIdentityController,
                       keyboardType: TextInputType.number,),
                     const SizedBox(height: 10,),
                CustomField(
                    prefixSize: 18,
                    hintText: 'البريد الاكتروني',
                    prefixIconColor: Theme.of(context).primaryColor,
                    controller: emailController,
                ),
                     const SizedBox(height: 10,),
                     CustomField(
                       prefixSize: 18,
                       hintText: 'الدخل الشهري',
                       prefixIconColor: Theme.of(context).primaryColor,
                       controller: monthlyIncomeController,
                       keyboardType: TextInputType.number,
                     ),
                     const SizedBox(height: 10,),
                     CustomField(
                       prefixSize: 18,
                       hintText: 'مجموع الالتزامات الشهريه',
                       prefixIconColor: Theme.of(context).primaryColor,
                       controller: totalMonthlyCommitmentsController,
                       keyboardType: TextInputType.number,
                     ),
                     const SizedBox(height: 10,),
                     CustomField(
                       prefixSize: 18,
                       hintText: 'مجموع المصروفات الشهريه',
                       prefixIconColor: Theme.of(context).primaryColor,
                       controller: totalMonthlyExpensesController,
                       keyboardType: TextInputType.number,
                     ),
                     const SizedBox(height: 10,),
                     (state is LoadingUpdateDataUser)?
                     const Center(child: CircularProgressIndicator(),):Padding(
                         padding: const EdgeInsets.symmetric(
                             vertical: defaultPadding),
                         child: CustomButton(
                             onPressed: () {
                               if(formKey.currentState!.validate()){
                                 if(cubit.file==null){
                                   Fluttertoast.showToast(msg: 'حدد الصوره');
                                 }else{
                                   cubit.updateDataUser(
                                       name: nameController.text,
                                       nationalIdentity: nationalIdentityController.text,
                                       monthlyIncome: monthlyIncomeController.text,
                                       email: emailController.text,
                                       totalMonthlyCommitments: totalMonthlyCommitmentsController.text,
                                       totalMonthlyExpenses: totalMonthlyExpensesController.text);
                                 }
                               }
                             },
                             text: 'تحديث المعلومات الشخصيه')),
                   ],
                 ),
               ),
             ),
           ),
         );
        },
        listener: (context, state){
          if(state is SuccessUpdateDataUser){
            Navigator.pop(context);
            BlocProvider.of<AppCubit>(context).file=null;
            BlocProvider.of<AppCubit>(context).getDateUser();
          }else if(state is ErrorUpdateDataUser){
            Fluttertoast.showToast(msg: 'لم يتم تحديث البيانات حاول مره اخري');
          }
        });
  }
   Widget show({required BuildContext context,
     required Function() camera,
     required Function() gallery,}){
     return AlertDialog(
       title:const  Text(
         'اختار صوره',
         textAlign: TextAlign.end,
         style: TextStyle(
             fontSize: 20,
             color: Colors.black,
             fontWeight: FontWeight.bold
         ),
       ),

       content: Directionality(
         textDirection: TextDirection.rtl,
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             InkWell(
               onTap: camera,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                   children:  [
                     Icon(Icons.photo,color: selectedPrimaryColor,),
                     const SizedBox(width: 10,),
                     Text('كاميرا',
                       style: TextStyle(
                           color: selectedPrimaryColor,fontSize: 20
                       ),)
                   ],
                 ),
               ),
             ),
             InkWell(
               onTap: gallery,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                   children:  [
                     Icon(Icons.camera,color:selectedPrimaryColor,),
                     const SizedBox(width: 10,),
                     Text('معرض',
                       style: TextStyle(
                           color: selectedPrimaryColor,fontSize: 20
                       ),)
                   ],
                 ),
               ),
             )
           ],
         ),
       ),
     );
   }
}
