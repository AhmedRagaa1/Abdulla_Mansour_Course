import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/Social_App/cubit/cubit.dart';
import 'package:flutter_app/models/Social_App/cubit/state.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state)
      {

      },
      builder: (context, state)
      {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).ProfileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel.name;
        phoneController.text = userModel.phone;
        bioController.text = userModel.bio;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions:
            [
              MaterialButton(
                onPressed: ()
                {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                child: Text(
                  'Update'.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.blue,

                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:
                [
                  if(state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 270,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children:
                      [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 220,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null ?
                                    NetworkImage(
                                      '${userModel.cover}',
                                    ) :
                                    FileImage(coverImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                  icon: CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 16,
                                    ),
                                  ),
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).getcoverImage();
                                  },
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null ?
                                NetworkImage(
                                  '${userModel.image}',
                                ) : FileImage(profileImage) ,
                              ),
                            ),
                            IconButton(
                              icon: CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                ),
                              ),
                              onPressed: ()
                              {
                                SocialCubit.get(context).getProfileImage();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(SocialCubit.get(context).ProfileImage != null || SocialCubit.get(context).coverImage != null )
                  Row(
                    children:
                    [
                     if(SocialCubit.get(context).ProfileImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            MaterialButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                  );
                                },
                              child: Text(
                                'upload profile'.toUpperCase(),
                              ),
                              color: Colors.blue,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              SizedBox(
                              height: 10,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              LinearProgressIndicator(),

                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if(SocialCubit.get(context).coverImage != null)
                        Expanded(
                        child: Column(
                          children: [
                            MaterialButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                  );
                                },
                              child: Text(
                                'upload cover'.toUpperCase(),
                              ),
                              color: Colors.blue,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              SizedBox(
                              height: 10,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).ProfileImage != null || SocialCubit.get(context).coverImage != null )
                    SizedBox(
                    height: 20,
                  ),
                  defaultformfield(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                          {
                            return 'name must not be empty';
                          }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.supervised_user_circle_sharp,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultformfield(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value)
                    {
                      if(value.isEmpty)
                      {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: Icons.info_outline,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultformfield(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value)
                    {
                      if(value.isEmpty)
                      {
                        return 'phone number must not be empty';
                      }
                      return null;
                    },
                    label: 'phone',
                    prefix: Icons.phone,
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
