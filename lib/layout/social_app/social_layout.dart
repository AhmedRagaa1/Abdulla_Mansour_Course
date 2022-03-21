import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/social_app/New_post/NewPost_Screen.dart';
import 'package:flutter_app/models/Social_App/cubit/cubit.dart';
import 'package:flutter_app/models/Social_App/cubit/state.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
        listener: (context, state)
        {
          if(state is SocialNewPostStates)
          {
            NavigateTo(context, NewPostScreen(),);
          }
        },
        builder: (context, state)
        {
          var cubit = SocialCubit.get(context);


          return Scaffold(
            appBar: AppBar
              (
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
              actions:
              [
                IconButton(
                    icon: Icon
                      (
                      Icons.notifications,
                    ),
                    onPressed: (){},
                ),
                IconButton(
                    icon: Icon
                      (
                      Icons.search_rounded,
                    ),
                    onPressed: (){},
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index)
                  {
                      cubit.changeBottomNav(index);
                  },
              items:
              [
                BottomNavigationBarItem(
                    icon:Icon(
                  Icons.home,
                ),
                  label: 'home',

                ),
                BottomNavigationBarItem(
                    icon:Icon(
                  Icons.chat,
                ),
                  label: 'chat',
                ),
                BottomNavigationBarItem(
                  icon:Icon(
                    Icons.upload_file,
                  ),
                  label: 'post',
                ),

                BottomNavigationBarItem(
                    icon:Icon(
                  Icons.settings,
                ),
                  label: 'settings',
                ),

              ],

            ),

          );
        },
        );

  }
}
