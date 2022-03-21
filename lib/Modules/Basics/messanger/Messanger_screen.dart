import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessangerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children:
          [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage("https://img.youm7.com/large/201902210334573457.jpg"),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
                "Chats",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.camera_alt,
              size: 16,
              color: Colors.white,
            ),
          ),
              onPressed: (){}
          ),
          IconButton(icon: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.edit,
              size: 16,
              color: Colors.white,
            ),
          ),
              onPressed: (){}
          ),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children:
                  [
                    Icon(
                      Icons.search,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Search",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index)=>bulidStoryItem(),
                    separatorBuilder:(context , index) => SizedBox(
                      width: 20,
                    ),
                    itemCount: 7,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder: (context, index) =>bulidChatItem(),
                  separatorBuilder:
                      (context , index) => SizedBox(
                   height: 20,
                  ) ,
                  itemCount: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
  //  bulid Item
  //  bulid list
  //  add item to list

  Widget bulidChatItem() => Row(
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage("https://scontent.fcai20-3.fna.fbcdn.net/v/t1.6435-9/232768651_631144264956115_3790212611337570665_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=8bfeb9&_nc_eui2=AeE8sIXEAjiTk2tzQGmbd7jNQ1HhC588msRDUeELnzyaxClTgE5IIkFrIjPeI1rZm17cU3yHHywpetVOi6gPbKqE&_nc_ohc=XUmO9plJQ5QAX8o9gFO&_nc_ht=scontent.fcai20-3.fna&oh=87993e965090004d69573ae60c152e31&oe=61400A8B"),
            ),
            CircleAvatar(
              radius: 7,
              backgroundColor: Colors.green,
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text(
                "Mohamed Gamal",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children:
                [
                  Expanded(
                    child: Text(
                      "واحشني يلا",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Text(
                    "02:00 pm",
                  ),
                ],
              ),

            ],
          ),
        ),
      ]
  );
  Widget  bulidStoryItem() => Container(
    width: 50,
    child: Column(
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage("https://scontent.fcai20-3.fna.fbcdn.net/v/t1.6435-1/p240x240/159217929_2943555705874541_482237361840596591_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=7206a8&_nc_eui2=AeEPhLLoI_K_NJp9CCgh7mj2uH7jW3wKArW4fuNbfAoCtZPmlba7U9a0wPAcgXl4y2joyXVDb070C8qpMBjMuhsv&_nc_ohc=143nzifVpl0AX-FWH_d&_nc_ht=scontent.fcai20-3.fna&oh=3d7c2737a1bc6a68e84bfc81e75cd54f&oe=613F2502"),
            ),
            CircleAvatar(
              radius: 7,
              backgroundColor: Colors.green,
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          "Ahmed Ragaa",
          maxLines: 2,
        ),
      ],
    ),
  );
}
