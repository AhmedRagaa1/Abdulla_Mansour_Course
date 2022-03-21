import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Shop__App/Login/cubit/states.dart';
import 'package:flutter_app/Modules/Shop__App/register/cubit/states.dart';
import 'package:flutter_app/models/Shop_App/login_model.dart';
import 'package:flutter_app/shared/network/end_points.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit(): super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel ;
  
  void  UserRegister({
  @required String name,
  @required String email,
  @required String password,
  @required String phone,
})
  {

    emit(ShopRegisterLoadingState());

    DioHelper.postData(
        url: REGISTER,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
    ).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromjson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility;
  bool ispassword = true;

  void changePasswordVisibility()
  {
    ispassword = !ispassword;

    suffix = ispassword ?   Icons.visibility : Icons.visibility_off;

    emit(ShopChangePasswordRegisterState());
  }
}