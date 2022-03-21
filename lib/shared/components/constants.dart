
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Shop__App/Login/ShopLogin_Screen.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_app/shared/network/Local/cache_helper.dart';

const defaultColor = Colors.blue;

void signout(context)
{
  CachHelper.RemoveData(key: 'token').then((value) {
    if(value)
    {
      NavigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';

String uId = '';
