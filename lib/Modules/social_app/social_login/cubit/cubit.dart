import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Shop__App/Login/cubit/states.dart';
import 'package:flutter_app/Modules/social_app/social_login/cubit/states.dart';
import 'package:flutter_app/models/Shop_App/login_model.dart';
import 'package:flutter_app/shared/network/end_points.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit(): super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  
   void  UserLogin({
   @required String email,
   @required String password,
 })
   {

     emit(SocialLoginLoadingState());

     FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password,
     ).then((value)
     {
       print(value.user.email);
       print(value.user.uid);
       emit(SocialLoginSuccessState(value.user.uid));
     }).catchError((error)
     {
       emit(SocialLoginErrorState(error.toString()));
     });


   }
   IconData suffix = Icons.visibility;
   bool ispassword = true;

  void changePasswordVisibility()
  {
    ispassword = !ispassword;

    suffix = ispassword ?   Icons.visibility : Icons.visibility_off;

    emit(SocialChangePasswordState());
  }
}