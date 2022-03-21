import 'package:flutter_app/models/Shop_App/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates
{
  ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates
{
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopChangePasswordState extends ShopLoginStates{}


