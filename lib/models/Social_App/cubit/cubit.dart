import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/Modules/social_app/Chats/Chats_Screen.dart';
import 'package:flutter_app/Modules/social_app/New_post/NewPost_Screen.dart';
import 'package:flutter_app/Modules/social_app/feeds/feeds_screen.dart';
import 'package:flutter_app/Modules/social_app/settings/Setting_Screen.dart';
import 'package:flutter_app/models/Social_App/Social_User_model.dart';
import 'package:flutter_app/models/Social_App/cubit/state.dart';
import 'package:flutter_app/models/Social_App/message_model.dart';
import 'package:flutter_app/models/Social_App/post_model.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialIinitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUsermodel userModel;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId)
        .get().then((value)
    {
      // print(value.data());
      userModel = SocialUsermodel.fromjson(value.data());
      emit(SocialGetUserSuccessStates());
    }
        ).catchError((error)
    {
      print(error.toString());
      emit(SocialGetUserErrorStates(error.toString()));
    });

  }

  int currentIndex = 0;

  List<Widget> screens=
  [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    SettingsScreen(),


  ];

  List<String> titles =
  [
    'Home',
    'Chats',
    'Add Post',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1)
      getUsers();
    if (index == 2)
      emit(SocialNewPostStates());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavStates());
    }
  }


  File ProfileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );


    if (pickedFile != null) {
      ProfileImage = File(pickedFile.path);
      emit(SocialProfileImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickerErrorState());

    }
  }

  File coverImage;

  Future<void> getcoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );


    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickerErrorState());

    }
  }


  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  })
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage
        .instance.ref()
        .child(
        'users/${Uri.file(ProfileImage.path).pathSegments.last}')
        .putFile(ProfileImage)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        // emit(SocialUpdateProfileImagePickerSuccessState());
         print(value);
         updateUser(
             name: name,
             phone: phone,
             bio: bio,
           image: value,
         );
      }).catchError((error)
      {
        emit(SocialUpdateProfileImagePickerErrorState());
      });
    })
        .catchError((error)
    {
      emit(SocialUpdateProfileImagePickerErrorState());

    });
  }


  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
  })
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage
        .instance.ref()
        .child(
        'users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        // emit(SocialUpdateCoverImagePickerErrorState());
        print(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
          cover: value,
        );
      }).catchError((error)
      {
        emit(SocialUpdateCoverImagePickerErrorState());
      });
    })
        .catchError((error)
    {
      emit(SocialUpdateCoverImagePickerErrorState());

    });
  }

//   void updateUserImages({
//   @required String name,
//   @required String phone,
//   @required String bio,
// })
//   {
//     emit(SocialUserUpdateLoadingState());
//
//     if(coverImage != null)
//     {
//       uploadCoverImage();
//     }else if(ProfileImage != null)
//     {
//        uploadProfileImage();
//     }else if(coverImage != null && ProfileImage != null )
//     {
//
//     }
//       else
//       {
//         updateUser(
//             name: name,
//             phone: phone,
//             bio: bio
//         );
//       }
//
//
//
//   }
  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
     String cover,
     String image,
  })
  {
    SocialUsermodel model = SocialUsermodel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel.email,
      cover: cover ??userModel.cover,
      image: image ?? userModel.image,
      uId: userModel.uId,
      isEmailVerified: false,
    );


    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value)
    {
      getUserData();

    }).catchError((error)
    {
      emit(SocialUserUpdateErrorState());
    });
  }

  File postImage;

  Future<void> getpostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );


    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickerErrorState());

    }
  }


  void removePostImage()
  {
    postImage = null;
    emit(SocialRemoveImageState());
  }

  void uploadPostImage({
    @required String dateTime,
    @required String text,
  })
  {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage
        .instance.ref()
        .child(
        'posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        print(value);
        createPost(
            dateTime: dateTime,
            text: text,
            postImage: value,
        );

      }).catchError((error)
      {
        emit(SocialCreatePostErrorState());
      });
    })
        .catchError((error)
    {
      emit(SocialCreatePostErrorState());

    });
  }

  void createPost({

    @required String dateTime,
    @required String text,
    String postImage,
  })
  {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel.name,
      image: userModel.image,
      uId: userModel.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage??'',
    );


    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value)
    {
        emit(SocialCreatePostSuccessState());
    }).catchError((error)
    {
      emit(SocialCreatePostErrorState());
    });
  }


  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts()
  {
     FirebaseFirestore.instance
         .collection('posts')
         .get()
         .then((value)
     {
       value.docs.forEach((element)
       {
         element.reference
         .collection('likes')
         .get()
         .then((value)
         {
           likes.add(value.docs.length);
           postsId.add(element.id);
           posts.add(PostModel.fromjson(element.data()));
         }).catchError((error)
         {

         });


       });

        emit(SocialGetPostSuccessStates());
     })
         .catchError((error)
     {
        emit(SocialGetPostErrorStates(error.toString()));
     });
  }


  void LikePost(String postId)
  {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(userModel.uId)
          .set({
        'like':true,
      })
          .then((value)
      {
        emit(SocialLikePostSuccessStates());
      })
          .catchError((error)
      {
        emit(SocialLikePostErrorStates(error.toString()));
      });
  }

  List<SocialUsermodel> users = [];

  void getUsers()
  {
    if(users.length == 0)
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value)
    {
      value.docs.forEach((element)
      {
        if(element.data()['uId'] != userModel.uId)


        users.add(SocialUsermodel.fromjson(element.data()));
        });

      emit(SocialGetAllUserSuccessStates());
    })
        .catchError((error)
        {
        emit(SocialGetAllUserErrorStates(error.toString()));
        });

   }


   void sendMessage({
  @required String receiverId,
  @required String dateTime,
  @required String text,
})
   {
      MessageModel model = MessageModel(
        text: text,
        senderId: userModel.uId,
        dateTime: dateTime,
        receiverId: receiverId,
      );

      FirebaseFirestore.instance
      .collection('users')
      .doc(userModel.uId)
      .collection('chats')
      .doc(receiverId)
      .collection('messages')
      .add(model.toMap())
      .then((value)
      {
         emit(SocialSendMessageSuccessStates());
      })
      .catchError((error)
      {
        emit(SocialSendMessageErrorStates(error.toString()));
      });


      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(userModel.uId)
          .collection('messages')
          .add(model.toMap())
          .then((value)
      {
        emit(SocialSendMessageSuccessStates());
      })
          .catchError((error)
      {
        emit(SocialSendMessageErrorStates(error.toString()));
      });

   }


   List<MessageModel>messages = [];

  void getMessages({
    @required String receiverId,
  })
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages = [];

      event.docs.forEach((element)
      {
         messages.add(MessageModel.fromjson(element.data()));
      });

      emit(SocialGetMessageSuccessStates());
    });
  }




}


