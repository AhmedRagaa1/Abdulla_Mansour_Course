import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/social_app/edit_profile/edit_profile_Screen.dart';
import 'package:flutter_app/models/Social_App/cubit/cubit.dart';
import 'package:flutter_app/models/Social_App/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/Components.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        var userModel = SocialCubit.get(context).userModel;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children:
              [
                Container(
                  height: 290,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children:
                    [
                      Align(
                        child: Container(
                          height: 240,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${userModel.cover}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              '${userModel.image}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    '${userModel.name}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  '${userModel.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Row(
                    children:
                    [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'post',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                '320',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                '10k',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                '10',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children:
                  [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (){},
                        child: Text(
                          'Add photo',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      onPressed: ()
                      {
                        NavigateTo(context, EditProfileScreen());
                      },
                      child: Icon(
                        Icons.edit_outlined,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children:
                //   [
                //     OutlinedButton(
                //         onPressed: ()
                //         {
                //           FirebaseMessaging.instance.subscribeToTopic('announcements');
                //         },
                //         child: Text(
                //           'subscribe',
                //         ),
                //     ),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     OutlinedButton(
                //         onPressed: ()
                //         {
                //           FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                //         },
                //         child: Text(
                //           'unsubscribe',
                //         ),
                //     ),
                //   ],
                // ),

              ],
            ),
          ),
        );
      }

    );
  }
}