import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Shop__App/Login/cubit/states.dart';
import 'package:flutter_app/models/Shop_App/login_model.dart';
import 'package:flutter_app/shared/network/end_points.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit(): super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel ;
  
  void  UserLogin({
  @required String email,
  @required String password,
})
  {

    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data: {
          'email': email,
          'password': password,
        },
    ).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromjson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility;
  bool ispassword = true;

  void changePasswordVisibility()
  {
    ispassword = !ispassword;

    suffix = ispassword ?   Icons.visibility : Icons.visibility_off;

    emit(ShopChangePasswordState());
  }
}