import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Shop__App/Login/cubit/states.dart';
import 'package:flutter_app/Modules/Shop__App/register/cubit/states.dart';
import 'package:flutter_app/Modules/social_app/Register/cubit/states.dart';
import 'package:flutter_app/models/Shop_App/login_model.dart';
import 'package:flutter_app/models/Social_App/Social_User_model.dart';
import 'package:flutter_app/shared/network/end_points.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit(): super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);


  
  void  UserRegister({
   @required String name,
   @required String email,
   @required String password,
   @required String phone,
 })
   {

     emit(SocialRegisterLoadingState());

     FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email,
         password: password,
     ).then((value)
     {

       userCreate(
           uId: value.user.uid,
           name: name,
           email: email,
           phone: phone,

       );
     }).catchError((error)
     {
       emit(SocialRegisterErrorState(error.toString()));
     });

      }
      void userCreate({
        @required String name,
        @required String email,
        @required String phone,
        @required String uId,
      })
      {

        SocialUsermodel model = SocialUsermodel(
          name: name,
          email: email,
          phone: phone,
          uId: uId,
          bio: 'write you bio ....',
          cover: 'https://img.freepik.com/free-photo/influencer-dancing-posting-social-media_23-2149194124.jpg?w=1380',
          image: 'https://img.freepik.com/free-photo/influencer-dancing-posting-social-media_23-2149194124.jpg?w=1380',
          isEmailVerified: false,
        );

         FirebaseFirestore.instance
             .collection('users')
             .doc(uId)
             .set(model.toMap()).then((value)
         {
           emit(SocialCreateUserSuccessState());
         }).catchError((error)
         {
           emit(SocialCreateUserErrorState(error.toString()));
         });
      }
  IconData suffix = Icons.visibility;
  bool ispassword = true;

  void changePasswordVisibility()
  {
    ispassword = !ispassword;

    suffix = ispassword ?   Icons.visibility : Icons.visibility_off;

    emit(SocialChangePasswordRegisterState());
  }
}