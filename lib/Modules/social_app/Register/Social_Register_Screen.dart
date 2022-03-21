import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/social_app/Register/cubit/cubit.dart';
import 'package:flutter_app/Modules/social_app/Register/cubit/states.dart';
import 'package:flutter_app/layout/social_app/social_layout.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterScreen extends StatelessWidget
{
  var formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState)
          {
            NavigateAndFinish(
              context,
              SocialLayout(),
            );
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
                          'Register now to communicate with friends',
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
                          suffix: SocialRegisterCubit.get(context).suffix,
                          ispassword: SocialRegisterCubit.get(context).ispassword,
                          suffixpressed: ()
                          {
                            SocialRegisterCubit.get(context).changePasswordVisibility();
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
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton
                              (onPressed: ()
                            {
                              SocialRegisterCubit.get(context).UserRegister(
                                  name: namecontroller.text,
                                  email: emailcontroller.text,
                                  password: passwordController.text,
                                  phone: phonecontroller.text,
                              );
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
