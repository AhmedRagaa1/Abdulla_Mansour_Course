
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/social_app/Chats_details/Chats_details_Screen.dart';
import 'package:flutter_app/models/Social_App/Social_User_model.dart';
import 'package:flutter_app/models/Social_App/cubit/cubit.dart';
import 'package:flutter_app/models/Social_App/cubit/state.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context , index) => buildChatItem(SocialCubit.get(context).users[index] , context),
            separatorBuilder: (context , index) => myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUsermodel model , context) =>  InkWell(

    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children:
        [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            '${model.name}',
            style: TextStyle(
              height: 1.4,
            ),
          ),


        ],
      ),
    ),
    onTap: ()
    {
      NavigateTo(context, ChatDetailScreen(
        userModel: model,
      ));
    },
  );
}