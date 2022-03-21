import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/News__App/Search/search_screen.dart';
import 'package:flutter_app/layout/New_App/cubit/cubit.dart';
import 'package:flutter_app/layout/New_App/cubit/states.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<Newscubit , NewsStates>(
       listener: (context ,  state){},
      builder: (context , state)
      {
        var cubit = Newscubit.get(context);

         return Scaffold(
           appBar: AppBar(
             title: Text(
               'News App',
             ),
             actions: [
               IconButton(
                   icon: Icon(
                     Icons.search_outlined,
                   ),
                   onPressed: ()
                   {
                      NavigateTo(context, SearchScreen());
                   },
               ),
               IconButton(
                   icon: Icon(
                     Icons.brightness_4_outlined,
                   ),
                   onPressed: ()
                   {
                     Newscubit.get(context).ChangeAppMode();
                   },
               ),
             ],
           ),

           body: cubit.Screens[cubit.currentindex],
           bottomNavigationBar: BottomNavigationBar(
             currentIndex: cubit.currentindex,
             onTap: (index)
             {
               cubit.changeBottomNavBar(index);
             },
             items: cubit.BottomItems,
           ),
         );
      },
    );
  }
}
