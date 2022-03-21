import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/social_app/Register/Social_Register_Screen.dart';
import 'package:flutter_app/Modules/social_app/social_login/cubit/cubit.dart';
import 'package:flutter_app/Modules/social_app/social_login/cubit/states.dart';
import 'package:flutter_app/layout/social_app/social_layout.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_app/shared/network/Local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SocialLoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState)
          {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          if(state is SocialLoginSuccessState)
          {
            CachHelper.SaveData(
                key: 'uId',
                value: state.uId,
            ).then((value)
            {
              NavigateAndFinish(
                  context, SocialLayout());
            });
          }
        },
        builder: (context,state)
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
                          ),),
                        Text(
                          'Login now to communicate with friends',
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
                          suffix: SocialLoginCubit.get(context).suffix,
                          ispassword: SocialLoginCubit.get(context).ispassword,
                          suffixpressed: ()
                          {
                            SocialLoginCubit.get(context).changePasswordVisibility();
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
                            //   if(formkey.currentState.validate())
                            //   {
                            //     SocialLoginCubit.get(context).UserLogin(
                            //       email: emailcontroller.text,
                            //       password: passwordController.text,
                            //     );
                            //   }
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton
                              (onPressed: ()
                            {

                                 SocialLoginCubit.get(context).UserLogin(
                                   email: emailcontroller.text,
                                   password: passwordController.text,
                                 );
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
                                NavigateTo(context, SocialRegisterScreen(),);
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
