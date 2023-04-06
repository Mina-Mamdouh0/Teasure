

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finology/Constance/constance.dart';
import 'package:finology/Widgets/common_button.dart';
import 'package:finology/bloc/app_cubit.dart';
import 'package:finology/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

enum AuthState { Phone, OTP }

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
   AuthState authState = AuthState.Phone;
   final TextEditingController phoneController = TextEditingController();
   final TextEditingController otpController = TextEditingController();
   String? verificationId;
   bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, MediaQuery.of(context).padding.bottom + defaultPadding),
          children: [
            Form(
              key: fKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  Center(
                    child: Text("Treasure",
                      style: Theme.of(context).textTheme.headline3!.copyWith(color: Theme.of(context).primaryColor, fontSize: 35),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 11),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text("تسجيل الدخول",style: Theme.of(context).textTheme.headline5),
                  ),
                  const SizedBox(height: defaultPadding),
                  if (authState == AuthState.Phone)
                    CustomField(
                      prefixSize: 18,
                      hintText: 'ادخل رقم الهاتف',
                      prefixIcon: FontAwesomeIcons.phone,
                      prefixIconColor: Theme.of(context).primaryColor,
                      controller:phoneController,
                      keyboardType: TextInputType.phone,),
                  if (authState == AuthState.OTP)
                    PinCodeTextField(
                      controller: otpController,
                      appContext: context,
                      length: 6,
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius:
                          BorderRadius.circular(defaultRadius),
                          fieldHeight: 30,
                          fieldWidth: 30,
                          activeColor: blueColor,
                          activeFillColor: blueColor,
                          selectedColor: blueColor,
                          selectedFillColor: blueColor,
                          inactiveColor: Theme.of(context).backgroundColor,
                          inactiveFillColor:
                          Theme.of(context).backgroundColor),
                      textStyle: const TextStyle(color: Colors.white),
                      cursorColor: Colors.grey,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v!.length < 3) {
                          return null;
                        } else {
                          return null;
                        }
                      },
                      beforeTextPaste: (text) {
                        return true;
                      }, onChanged: (String value) {  },
                    ),
                  const SizedBox(height: defaultPadding),
                  isLoading?
                  const Center(child: CircularProgressIndicator(),):Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding * 2.2),
                      child: CustomButton(
                          onPressed: () async{
                            if(fKey.currentState!.validate()){
                              setState(() {
                                isLoading=true;
                              });
                              if (authState == AuthState.Phone) {
                                await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber: phoneController.text.trim(),
                                    verificationCompleted: (phoneCredentials) {
                                      signIn(phoneCredentials, context);
                                      setState(() {
                                        isLoading=false;
                                      });
                                    },
                                    verificationFailed: (error) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(error.message!)));
                                      setState(() {
                                        isLoading=false;
                                      });
                                    },
                                    codeSent: (verificationId, resendToken) {
                                      setState(() {
                                        this.verificationId = verificationId;
                                        authState = AuthState.OTP;
                                        isLoading=false;
                                      });
                                    },
                                    codeAutoRetrievalTimeout: (verificationId) => null);
                              } else {
                                var cred = PhoneAuthProvider.credential(
                                    verificationId: verificationId!,
                                    smsCode: otpController.text.trim());
                                setState(() {
                                  isLoading=false;
                                });
                                await signIn(cred, context);
                              }
                            }
                          },
                          text: authState == AuthState.Phone ? 'ارسال رساله' : 'تاكيد')),
                  SizedBox(height: MediaQuery.of(context).size.height / 5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn(PhoneAuthCredential cred, BuildContext context) async {
    final result = await FirebaseAuth.instance.signInWithCredential(cred);
    FirebaseFirestore.instance.collection('Users').get()
    .then((value) {
      for (var element in value.docs) {
        if(element.id==result.user!.uid){
          BlocProvider.of<AppCubit>(context).getDateUser();
          Navigator.pushReplacementNamed(
              context, Routes.costomeBottomBar);
        }else{
            Navigator.pushReplacementNamed(
                context, Routes.infoData);
        }
      }});

  }
}
