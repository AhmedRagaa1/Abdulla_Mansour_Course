import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Shop__App/On_boarding/on_boarding_Screen.dart';
import 'package:flutter_app/Modules/native_code.dart';
import 'package:flutter_app/Modules/social_app/social_login/social_login_screen.dart';
import 'package:flutter_app/layout/New_App/cubit/cubit.dart';
import 'package:flutter_app/layout/New_App/cubit/states.dart';
import 'package:flutter_app/layout/New_App/news_layout.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/cubit.dart';
import 'package:flutter_app/layout/Shop_App/ShopLayout.dart';
import 'package:flutter_app/layout/social_app/social_layout.dart';
import 'package:flutter_app/models/Social_App/cubit/cubit.dart';
import 'package:flutter_app/shared/Bloc_observer.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_app/shared/network/Local/cache_helper.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_app/shared/styles/Themes.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

import 'Modules/Shop__App/Login/ShopLogin_Screen.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

}


void main() async {

   WidgetsFlutterBinding.ensureInitialized();

   await Firebase.initializeApp();
   var token =await FirebaseMessaging.instance.getToken();

   print(token);

   FirebaseMessaging.onMessage.listen((event)
   {
     print(event.data.toString());
   });

   FirebaseMessaging.onMessageOpenedApp.listen((event)
   {
     print(event.data.toString());
   });
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    Bloc.observer = MyBlocObserver();
    DioHelper.init();
     await CachHelper.init();

    bool isDark =CachHelper.getData(key: 'isDark');

    Widget widget;

    // bool onboarding =CachHelper.getData(key: 'onboarding');
    //
     token =CachHelper.getData(key: 'token');

     uId =CachHelper.getData(key: 'uId');
    //
    // if(onboarding != null)
    // {
    //   if (token != null) widget = ShopLayout();
    //   else widget = ShopLoginScreen();
    // }else
    //   {
    //     widget = OnBoardingScreen();
    //   }

   if(uId != null)
     {
       widget = SocialLayout();
     }else
       {
         widget = SocialLoginScreen();
       }



    runApp(MyApp(
        isDark: isDark,
      startwidget: widget,
    ));



}
class MyApp extends StatelessWidget
{

  final bool isDark;

  final Widget startwidget;

  MyApp({this.isDark , this.startwidget});

  @override
  Widget build(BuildContext context)
  {

    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context) => Newscubit()..getBusiness()..ChangeAppMode(
      FormShared:isDark,
      ),
        ),
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCateogries()..getUserData()..getFavorites(),
        ),
        BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts()
        ),


      ],
      child: BlocConsumer<Newscubit , NewsStates>(
        listener: (context , state){},
        builder: (context , state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: Newscubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            home: startwidget,
          );
        },

      ),
    );

  }


}

