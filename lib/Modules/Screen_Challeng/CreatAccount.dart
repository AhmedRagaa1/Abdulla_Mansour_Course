import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Screen_Challeng/login_Screen_Challeng.dart';

class CreatAccount extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginChalleng()));
                }, icon: Icon(Icons.arrow_back)),
              ],
            ),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Let's Get Started!", style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 35,),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Create an account to Q Allure to get all featues',
                style: TextStyle(color: Colors.grey),),
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  prefixIcon: Icon(Icons.person_outline),
                  labelText: 'User Name',
                ),
              ),

            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'E_mail',
                ),
              ),

            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  prefixIcon: Icon(Icons.phone_android),
                  labelText: 'Phone',
                ),
              ),

            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  prefixIcon: Icon(Icons.lock_open),
                  labelText: 'Password',
                ),
              ),

            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  prefixIcon: Icon(Icons.lock_open),
                  labelText: 'Confirm Password',
                ),
              ),

            ),
            SizedBox(height: 30,),
            FlatButton(
                onPressed: () {},
                color: Colors.indigo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                  child: Text('CREATE', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),),
                )
            ),
            SizedBox(height: 40,),
            Container(width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  TextButton(onPressed: ()
                  {
                    Navigator.pop(context);
                  },
                      child: Text('Login here',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



