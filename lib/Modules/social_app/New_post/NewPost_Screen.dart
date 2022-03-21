import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Social_App/cubit/cubit.dart';
import 'package:flutter_app/models/Social_App/cubit/state.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget
{

var textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Create post',
              actions:
              [
                MaterialButton(
                  onPressed: ()
                  {
                    var now = DateTime.now();

                    if(SocialCubit.get(context).postImage == null)
                    {
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }else
                      {
                        SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                            text: textController.text,
                        );
                      }
                  },
                  child: Text(
                    'Post'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children:
              [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                  height: 10,
                ),
                Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        '${SocialCubit.get(context).userModel.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        '${SocialCubit.get(context).userModel.name}',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind.... 😉',
                      border: InputBorder.none,
                    ),
                  ),

                ),
                SizedBox(
                  height: 20,
                ),
                if(SocialCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image:FileImage(SocialCubit.get(context).postImage),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.close,
                          size: 16,
                        ),
                      ),
                      onPressed: ()
                      {
                        SocialCubit.get(context).removePostImage();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getpostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Icon(
                                Icons.image_sharp,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'add photo',
                              ),
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: (){},
                          child: Text(
                            '# tags',
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
