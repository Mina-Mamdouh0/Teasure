abstract class AppState {}

class InitialState extends AppState{}

class LoadingStoreDataState extends AppState{}
class SuccessStoreDataState extends AppState{}
class ErrorStoreDataState extends AppState{
  final String error;
  ErrorStoreDataState(this.error);
}
class ChangeCheckBoxState extends AppState{}

class LoadingGetUserScreen extends AppState{}
class SuccessGetUserScreen extends AppState{}
class ErrorGetUserScreen extends AppState{
  final String error;
  ErrorGetUserScreen(this.error);
}

class LoadingUpdateDataUser extends AppState{}
class SuccessUpdateDataUser extends AppState{}
class ErrorUpdateDataUser extends AppState{
  final String error;
  ErrorUpdateDataUser(this.error);
}
class ChangeImageState extends AppState{}
class ChangeDateTimeState extends AppState{}
class ChangeMoneyOfMouthState extends AppState{}
class ChangeNumOfMouthState extends AppState{}

class LoadingUploadPlans extends AppState{}
class SuccessUploadPlans extends AppState{}
class ErrorUploadPlans extends AppState{
  final String error;
  ErrorUploadPlans(this.error);
}


class LoadingGetPlans extends AppState{}
class SuccessGetPlans extends AppState{}
class ErrorGetPlans extends AppState{
  final String error;
  ErrorGetPlans(this.error);
}















