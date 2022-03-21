import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/shared/components/Components.dart';

class Loginscreen  extends StatefulWidget {
  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  var formkey =GlobalKey<FormState>();
  bool ispasswordshow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  defaultformfield(
                    controller: emailcontroller,
                    label: "Email address",
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,
                    validate: (value){
                      if(value.isEmpty)
                      {
                        return "Email address  must not be empty";
                      }
                      return null;
                    }
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultformfield(
                      controller: passcontroller,
                      label: "Password",
                      prefix: Icons.lock,
                      suffix: ispasswordshow ?Icons.visibility:Icons.visibility_off,
                      ispassword: ispasswordshow,
                      suffixpressed: ()
                      {
                        setState(() {
                          ispasswordshow=!ispasswordshow;
                        });
                      },
                      type: TextInputType.visiblePassword,
                      validate: (value){
                        if(value.isEmpty)
                        {
                          return "Password must not be empty";
                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    function: (){
                      if(formkey.currentState.validate())
                        {
                          print(emailcontroller.text);
                          print(passcontroller.text);
                        }
                    },
                    text: "login",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don\'t have an account ?",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                          onPressed: (){},
                          child:Text(
                            "Register Now",
                          ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
