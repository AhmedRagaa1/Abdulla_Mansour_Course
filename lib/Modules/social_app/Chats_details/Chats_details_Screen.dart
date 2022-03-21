import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Social_App/Social_User_model.dart';
import 'package:flutter_app/models/Social_App/cubit/cubit.dart';
import 'package:flutter_app/models/Social_App/cubit/state.dart';
import 'package:flutter_app/models/Social_App/message_model.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatDetailScreen extends StatelessWidget
{
  SocialUsermodel userModel;
  ChatDetailScreen(
  {
    this.userModel,
});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context)
      {
        SocialCubit.get(context).getMessages(
            receiverId: userModel.uId,
        );


        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context , state){},
          builder: (context , state)
          {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        '${userModel.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${userModel.name}',
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length >= 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children:
                    [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                            itemBuilder: (context , index)
                            {
                              var message = SocialCubit.get(context).messages[index];

                              if(SocialCubit.get(context).userModel.uId == message.senderId)
                                return buildMyMessage(message);

                              return buildMessage(message);
                              },
                            separatorBuilder: (context , index) => SizedBox(
                              height: 15,
                            ),
                            itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300],
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15,),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children:
                          [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here ...👁',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: userModel.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                },
                                minWidth: 1,
                                child: Icon(
                                  Icons.send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          )
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Text(
        model.text,
      ),
    ),
  );


  Widget buildMyMessage(MessageModel model) =>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: defaultColor.withOpacity(.5),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          )
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Text(
        model.text,
      ),
    ),
  );
}
