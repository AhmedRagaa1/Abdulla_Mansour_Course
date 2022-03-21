import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/users/user_model.dart';




class UserScreen extends StatelessWidget {
  List<UsersModel> Users = [
    UsersModel(
      id: 1,
      name: "Ahmed Ragaa",
      phone: "01122911235",
    ),
    UsersModel(
      id: 2,
      name: "Mohamed Ragaa",
      phone: "01122411235",
    ),
    UsersModel(
      id: 3,
      name: "Ashraf Ragaa",
      phone: "01122916335",
    ),
    UsersModel(
      id: 1,
      name: "Ahmed Ragaa",
      phone: "01122911235",
    ),
    UsersModel(
      id: 1,
      name: "Ahmed Ragaa",
      phone: "01122911235",
    ),
    UsersModel(
      id: 1,
      name: "Ahmed Ragaa",
      phone: "01122911235",
    ),
    UsersModel(
      id: 1,
      name: "Ahmed Ragaa",
      phone: "01122911235",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users",
        ),
      ),
      body:ListView.separated(
          itemBuilder: (context, index) =>buliiduseritem(Users[index]),
          separatorBuilder: (context, index) =>Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
          itemCount: Users.length,
      ),
    );
  }

  Widget buliiduseritem(UsersModel User) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        CircleAvatar(
          radius: 25,
          child: Text(
            "1",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children:
          [
            Text(
              "Ahmed Ragaa",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "01122911235",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
