import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Screen_Challeng/CreatAccount.dart';
import 'package:flutter_app/shared/components/Components.dart';

// ignore: must_be_immutable
class LoginChalleng extends StatefulWidget {
  @override
  _LoginChallengState createState() => _LoginChallengState();
}

class _LoginChallengState extends State<LoginChalleng> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  bool ispasswordshow = true;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 20,
    ),
    child: SingleChildScrollView(
      child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
      [
      Image(
      image: AssetImage('assets/images/photo_2021.jpg'),
      height: 170,
      width: 360,
      ),
      SizedBox(
      height:5,
      ),
      Text(
      'Welcome Back !',
      style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 30,
      ),
      ),
      SizedBox(
      height: 7,
      ),
      Text(
      'login to your existing account of Q Allure ',
      style: TextStyle(
      color: Colors.grey,
        fontSize:15,
      ),
      ),
      SizedBox(
      height: 20,
      ),
        defaultformfield(
            controller: emailcontroller,
            type: TextInputType.emailAddress,
            validate: (value){
            if(value.isEmpty)
            {
               return "Email address  must not be empty";
            }
               return null;
            },
            label: 'Account',
            prefix: Icons.account_circle,
          radius: 20,
        ),
        SizedBox(
          height: 20,
        ),
        defaultformfield(
            controller: passwordcontroller,
            radius: 20,
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
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Forget Password ?',
              style: TextStyle(
                color: Colors.black,
                fontSize:15,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        defaultButton(
            function: (){
        if(formkey.currentState.validate())
        {
        print(emailcontroller.text);
        print(passwordcontroller.text);
        }
        },
          text: "LOG In",
          width: 200,
          raduis: 20,
          height: 50,
          background: Colors.indigo,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Or connect using ',
          style: TextStyle(
            color: Colors.grey,
            fontSize:15,
          ),
        ),
        SizedBox(
          height: 22,
        ),
        Row(
          children: [
            Container(

              width: 150,
              height: 40,
              color: Colors.pinkAccent,
              child: TextButton(
                  onPressed: (){},
                  child: Text(
                    'Google',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 150,
              height: 40,
              color: Colors.indigoAccent,
              child: TextButton(
                onPressed: (){},
                child: Text(
                  'Facebook',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Do not have an account ?',
              style: TextStyle(
                color: Colors.black,
                fontSize:15,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatAccount()
                      ),
                  );
                },
                child: Text(
                  'sign in',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
          ],
        ),



        ]
      ),
    ),
    ),
    );
  }
}
