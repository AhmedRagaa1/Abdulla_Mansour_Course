import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Shop__App/Login/cubit/cubit.dart';
import 'package:flutter_app/Modules/Shop__App/Login/cubit/states.dart';
import 'package:flutter_app/Modules/Shop__App/register/cubit/cubit.dart';
import 'package:flutter_app/Modules/Shop__App/register/cubit/states.dart';
import 'package:flutter_app/Modules/Shop__App/register/cubit/states.dart';
import 'package:flutter_app/Modules/Shop__App/register/cubit/states.dart';
import 'package:flutter_app/Modules/Shop__App/register/cubit/states.dart';
import 'package:flutter_app/layout/Shop_App/ShopLayout.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_app/shared/network/Local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopRegisterScreen extends StatelessWidget
{
  var formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.data.token);
              print(state.loginModel.message);


              CachHelper.SaveData(
                  key: 'token', value: state.loginModel.data.token).then((
                  value) {
                token = state.loginModel.data.token;

                NavigateAndFinish(
                    context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);

              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultformfield(
                          controller: namecontroller,
                          type: TextInputType.name,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Please enter your Name';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        defaultformfield(
                          controller: emailcontroller,
                          type: TextInputType.emailAddress,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        defaultformfield(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          ispassword: ShopRegisterCubit.get(context).ispassword,
                          suffixpressed: ()
                          {
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return '  Password is too short';
                            }
                          },

                          onSubmit: (value)
                          {},
                          label: 'Password',
                          prefix: Icons.lock,
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        defaultformfield(
                          controller: phonecontroller,
                          type: TextInputType.phone,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Please enter your phone number';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton
                              (onPressed: ()
                            {
                              if(formkey.currentState.validate())
                              {
                                ShopRegisterCubit.get(context).UserRegister(
                                  name: namecontroller.text,
                                  email: emailcontroller.text,
                                  password: passwordController.text,
                                  phone: phonecontroller.text,
                                );
                              }

                            },
                              child: Text(
                                'register'.toUpperCase(),
                              ),
                            ),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
