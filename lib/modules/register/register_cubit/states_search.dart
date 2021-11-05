import 'package:shop_app/models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialStates extends ShopRegisterStates {}



class ShopRegisterLoadingStates extends ShopRegisterStates {}

class ShopRegisterSuccessStates extends ShopRegisterStates {
  final ShopLoginModel loginModel;

  ShopRegisterSuccessStates(this.loginModel);
}

class ShopRegisterErrorStates extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorStates(this.error);
}



class ShopRegisterChangePasswordVisibility extends ShopRegisterStates {}

