
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finology/bloc/app_state.dart';
import 'package:finology/models/plan_model.dart';
import 'package:finology/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  bool isSelected = false;
  void changeCheckBox(bool val){
    isSelected=val;
    emit(ChangeCheckBoxState());
  }


  void storeDate({
    required String name,
    required String email,
  }) async {
    emit(LoadingStoreDataState());
   if(FirebaseAuth.instance.currentUser!=null){
     SignUpModel signUpModel = SignUpModel(
         name: name,
         email: email,
         phone:  FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
         uId: FirebaseAuth.instance.currentUser!.uid,
         createdAt: Timestamp.now(),
         monthlyIncome: '0.0',
         nationalIdentity: '0000',
         plans: [],
         totalMonthlyCommitments: '0.0',
         totalMonthlyExpenses: '0.0',
         profileImage: 'https://media.istockphoto.com/id/1223671392/vector/default-profile-picture-avatar-photo-placeholder-vector-illustration.jpg?s=612x612&w=0&k=20&c=s0aTdmT5aU6b8ot7VKm11DeID6NctRCpB755rA1BIP0='
     );
     await FirebaseFirestore.instance
         .collection('Users')
         .doc(FirebaseAuth.instance.currentUser!.uid)
         .set(signUpModel.toMap()).then((value){
       emit(SuccessStoreDataState());
     }).onError((error, stackTrace){
       emit(ErrorStoreDataState(error.toString()));
     });
   }
  }


  SignUpModel? signUpModel;
  Future<void> getDateUser()async{
    if(FirebaseAuth.instance.currentUser!=null){
      emit(LoadingGetUserScreen());
      FirebaseFirestore.instance
          .collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get().
      then((value){
        signUpModel=SignUpModel.formJson(value.data()!);
        emit(SuccessGetUserScreen());
      }).onError((error,_){
        emit(ErrorGetUserScreen(error.toString()));
      });
    }
  }

  String date='${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
  void updateDate(DateTime dateTime){
    date='${dateTime.year}/${dateTime.month}/${dateTime.day}';
    emit(ChangeDateTimeState());
  }

  double moneyOfMouth=0.0;
  void changeMoneyOfMouth({required String moneyMouth,required String totalMoney}){
    moneyOfMouth=(int.parse(totalMoney)/int.parse(moneyMouth)).ceilToDouble();
    emit(ChangeMoneyOfMouthState());
  }

  int numOfMouth=0;
  void changeNumOfMouth({required String numMouth,required String totalMoney}){
    numOfMouth=(int.parse(totalMoney)~/int.parse(numMouth));
    emit(ChangeNumOfMouthState());
  }


  void uploadPlans({
  required String executionStartTime,
  required String namePlan,
  required String numOfMouth,
  required String totalMoney,
  required String moneyOfMouth,
  required String fishedMoney,
}){
    if(FirebaseAuth.instance.currentUser!=null){
      emit(LoadingUploadPlans());
      String idPlan=const Uuid().v4();
      PlanModel planModel=PlanModel
        (status: 'Padding',
          executionStartTime: executionStartTime,
          moneyInCurrentMouth: moneyOfMouth,
          remainingMoney: fishedMoney,
          moneyOfMouth: moneyOfMouth,
          namePlan: namePlan,
          numOfMouth: numOfMouth,
          planId: idPlan,
          fishedMoney: fishedMoney,
          totalMoney: totalMoney,
          userCreateId: FirebaseAuth.instance.currentUser!.uid,
          createdAt: Timestamp.now());
      FirebaseFirestore.instance.collection('Plans').doc(idPlan)
      .set(planModel.toMap()).then((value){
        emit(SuccessUploadPlans());
      }).onError((error, stackTrace){
        emit(ErrorUploadPlans(error.toString()));
      });
    }
  }

  List<PlanModel> planList=[];
  void getPlans(){
    if(FirebaseAuth.instance.currentUser!=null){
      planList=[];
      emit(LoadingGetPlans());
      FirebaseFirestore.instance.collection('Plans').
      where('UserCreateId',isEqualTo:FirebaseAuth.instance.currentUser!.uid )
          .get().then((value){
        for (var element in value.docs) {
          planList.add(PlanModel.formJson(element.data()));
        }
        emit(SuccessGetPlans());
      }).onError((error, stackTrace){
        emit(ErrorGetPlans(error.toString()));
      });
    }
  }

  File? file;
  void changeImage(String imagePath){
    file=File(imagePath);
    if(file!=null){
      emit(ChangeImageState());
    }
  }
  String? url;
  void updateDataUser({
  required String name,
  required String nationalIdentity,
  required String monthlyIncome,
  required String totalMonthlyCommitments,
  required String totalMonthlyExpenses,
  required String email,
})async{
    if(FirebaseAuth.instance.currentUser!=null){
      emit(LoadingUpdateDataUser());
      final ref = FirebaseStorage.instance.ref().child('UsersImage').
      child(FirebaseAuth.instance.currentUser!.uid).
      child('Image.jpg');
      await ref.putFile(file!).then((p0) async {
        url = await ref.getDownloadURL();
      });
    }
      FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
        'Name':name,
        'NationalIdentity':nationalIdentity,
        'MonthlyIncome':monthlyIncome,
        'TotalMonthlyCommitments':totalMonthlyCommitments,
        'TotalMonthlyExpenses':totalMonthlyExpenses,
        'ProfileImage':url,
        'Email':email,
      }).then((value){
        emit(SuccessUpdateDataUser());
      }).onError((error, stackTrace){
        emit(ErrorUpdateDataUser(error.toString()));
      });
    }

}