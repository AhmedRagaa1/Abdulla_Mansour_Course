import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Modules/Shop__App/Login/cubit/cubit.dart';
import 'package:flutter_app/Modules/Shop__App/Login/cubit/states.dart';
import 'package:flutter_app/Modules/Shop__App/register/Shop_Register_Screen.dart';
import 'package:flutter_app/layout/Shop_App/ShopLayout.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_app/shared/network/Local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginScreen extends StatelessWidget
{

  var formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var emailcontroller = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit , ShopLoginStates>(
        listener: (context , state)
        {
          if(state is ShopLoginSuccessState)
        {
        if(state.loginModel.status)
        {
        print(state.loginModel.data.token);
        print(state.loginModel.message);


        CachHelper.SaveData(
            key: 'token', value: state.loginModel.data.token).then((value)
        {
          token = state.loginModel.data.token;

        NavigateAndFinish(
            context, ShopLayout());
        });


        }else
              {
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
        builder: (context , state)
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
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
                          suffix: ShopLoginCubit.get(context).suffix,
                          ispassword: ShopLoginCubit.get(context).ispassword,
                          suffixpressed: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return '  Password is too short';
                            }
                          },

                          onSubmit: (value)
                          {
                            if(formkey.currentState.validate())
                            {
                              ShopLoginCubit.get(context).UserLogin(
                                email: emailcontroller.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton
                              (onPressed: ()
                            {
                              if(formkey.currentState.validate())
                              {
                                ShopLoginCubit.get(context).UserLogin(
                                  email: emailcontroller.text,
                                  password: passwordController.text,
                                );
                              }

                            },
                              child: Text(
                                'login'.toUpperCase(),
                              ),
                            ),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              'don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: ()
                              {
                                NavigateTo(context, ShopRegisterScreen(),);
                              },
                              child: Text(
                                'register'.toUpperCase(),
                              ),
                            ),
                          ],
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
