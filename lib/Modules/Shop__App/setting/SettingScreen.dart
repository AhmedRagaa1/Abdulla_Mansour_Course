import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/cubit.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/states.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context , state)
      {
        if(state is ShopSuccessUserDataState)
        {
          namecontroller.text = state.loginModel.data.name;
          emailcontroller.text = state.loginModel.data.email;
          phonecontroller.text = state.loginModel.data.phone;
        }
      },
      builder: (context,state)
      {
        var model = ShopCubit.get(context).usermodel;

        namecontroller.text = model.data.name;
        emailcontroller.text = model.data.email;
        phonecontroller.text = model.data.phone;


        return ConditionalBuilder(
          condition: ShopCubit.get(context).usermodel != null,
          builder: (context )=>  Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children:
                  [
                    if(state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultformfield(
                      controller: namecontroller,
                      type: TextInputType.name,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                        {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'name',
                      prefix: Icons.person,
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    defaultformfield(
                      controller: emailcontroller,
                      type: TextInputType.emailAddress,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                        {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                      label: 'Email Address',
                      prefix: Icons.email,
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    defaultformfield(
                      controller: phonecontroller,
                      type: TextInputType.phone,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                        {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Container(
                      width: double.infinity,
                      color: Colors.blue,
                      child: TextButton(
                        onPressed: ()
                        {

                          if(formKey.currentState.validate())
                          {
                            ShopCubit.get(context).UpdateUserData(
                              name: namecontroller.text,
                              email: emailcontroller.text,
                              phone: phonecontroller.text,
                            );
                          }


                        },
                        child: Text(
                          'update'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Container(
                      width: double.infinity,
                      color: Colors.blue,
                      child: TextButton(
                          onPressed: ()
                          {
                            signout(context);
                            },
                          child: Text(
                            'logout'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}