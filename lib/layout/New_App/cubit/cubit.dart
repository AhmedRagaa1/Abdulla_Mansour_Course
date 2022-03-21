import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/News__App/Busines/busines_screen.dart';
import 'package:flutter_app/Modules/News__App/Science/science_screen.dart';
import 'package:flutter_app/Modules/News__App/Sports/sports_screen.dart';
import 'package:flutter_app/layout/New_App/cubit/states.dart';
import 'package:flutter_app/shared/network/Local/cache_helper.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Newscubit extends Cubit <NewsStates>
{
  Newscubit() : super(NewsIntialState());

  static Newscubit get(context) => BlocProvider.of(context);

  int currentindex = 0 ;

  List<BottomNavigationBarItem> BottomItems =
  [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports_esports_rounded,
        ),
        label: 'Sports',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science',
    ),

  ];

  List<Widget> Screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];

  void changeBottomNavBar(int index)
  {
    currentindex = index;
    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    emit(NewsBottomNavState());
  }

  List< dynamic> business =[];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'3265fec3bbc04be5b22cc918d76a47e6'
      },
    ).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewGetBusinessErrorState(error.toString()));
    });
  }


  List< dynamic> sports =[];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'3265fec3bbc04be5b22cc918d76a47e6'
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewGetSportsErrorState(error.toString()));
      });
    } else
    {
      emit(NewGetSportsSuccessState());
    }


  }

  List< dynamic> science =[];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if(science.length==0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'3265fec3bbc04be5b22cc918d76a47e6'
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewGetScienceErrorState(error.toString()));
      });
    }else
      {
        emit(NewGetScienceSuccessState());
      }
  }



  List< dynamic> search =[];

  void getsearch(String value)
  {
    emit(NewsGetSearchLoadingState());


    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'3265fec3bbc04be5b22cc918d76a47e6'
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewGetSearchErrorState(error.toString()));
    });
  }

  bool isDark = false;

  void ChangeAppMode({bool FormShared})
  {
    if(FormShared != null)
    {
      isDark = FormShared;
      emit(NewsChangeModeState());
    }

    else
    {
      isDark= !isDark;
      CachHelper.putBoolean(key: 'isDark', value: isDark
      ).then((value)
      {
        emit(NewsChangeModeState());

      });
    }

  }
}




