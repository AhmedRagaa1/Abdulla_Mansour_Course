import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/News__App/web_view/web_viewScreen.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/cubit.dart';
import 'package:flutter_app/layout/todo_App/cubit_home_layout/cubit.dart';
import 'package:flutter_app/shared/components/constants.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double height =0,
  bool isuppercase =true,
  double raduis = 0.0,
  Function function,
  @required String text,
}) =>
Container(
  width: width,
  height: height,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isuppercase ?text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      raduis,
    ),
    color: background,
  ),
);

// ignore: non_constant_identifier_names
Widget  defaultformfield({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChanged,
  Function ontap,
  double radius =0,
  bool isclickable = true,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixpressed,
  bool ispassword : false,
}) => Container(

  child:   TextFormField(

  controller: controller,

    obscureText: ispassword,

  keyboardType:TextInputType.emailAddress ,

  onFieldSubmitted:onSubmit,

  onChanged: onChanged,

  onTap: ontap,


  enabled: isclickable,

  validator: validate,

  decoration: InputDecoration(

  labelText: label,

  prefixIcon: Icon(

  prefix,

  ),

  suffixIcon: suffix != null ? IconButton(

    onPressed: suffixpressed,

    icon:   Icon(

      suffix,

    ),

  ) :null,

  border: OutlineInputBorder(


      borderRadius: BorderRadius.circular(
        radius,
      ),
    ),

  ),

  ),

  );




Widget getlist(Map model,context){
  return Dismissible(
    key: Key(model['id'].toString() ),
    onDismissed: (dir){
      AppCubit.get(context).deleteDataBase(id: model['id']);

    },
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child:   Row(

        children: [

          CircleAvatar(

            radius: 40.0,

            child: Text('${model['time']}')

            ,

          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model['title']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text('${model['data']}',style: TextStyle(color: Colors.grey),),
              ],
            ),
          ),
          SizedBox(width: 20,),
          IconButton(
              onPressed: (){
                AppCubit.get(context).uodateDataBase(status: 'Done', id: model['id']);
              },
              icon: Icon(Icons.check_box,color: Colors.orangeAccent,)),
          IconButton(
              onPressed: (){
                AppCubit.get(context).uodateDataBase(status: 'Arachive', id: model['id']);

              },
              icon: Icon(Icons.archive,color: Colors.black38,)),


        ],

      ),
    ),
  );
}
Widget check(){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.menu,size: 80,color: Colors.grey,),
        Text('No Tasks Yet Please Add Some Tasks',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
      ],
    ),
  );
}

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    height: 1.0,
    width: double.infinity,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(articles,context) => InkWell(
  onTap: ()
  {
    NavigateTo(context, WebViewScreen(
      articles['url']
    ),
    );
  },
  child:   Padding(

    padding: const EdgeInsets.all(20),

    child: Row(

      children:

      [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),

            image: DecorationImage(

              image: NetworkImage('${articles['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),



        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children:

              [

                Expanded(

                  child: Text(

                    '${articles['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${articles['publishedAt']}',

                  style: TextStyle(

                    color: Colors.grey,

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget articlebulider(list , context , )=>ConditionalBuilder(
  condition: list.length>0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context , index) => buildArticleItem(list[index] , context),
    separatorBuilder: (context , index) => myDivider(),
    itemCount: 10,
  ),
  fallback: (context) =>  Center(child: CircularProgressIndicator()),
);




// ignore: non_constant_identifier_names
void NavigateTo(context , widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget,
  ),
);
void NavigateAndFinish(context , widget) => Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) =>widget,
    ),
    result: (route)
    {
      return false;
    },
);

Widget buildListProduct( model , context , {bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children:
      [
        Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:
            [
              Image(
                image: NetworkImage(model.image),
                width: 140,
                height: 140,
              ),
              if(model.discount != 0 && isOldPrice )
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5,),
                  child: Text(
                    'discount'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                    ),
                  ),
                ),
            ]
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if(model.discount != 0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).ChangeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favorites[model.id] ?  defaultColor:Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) => AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(
      Icons.arrow_back_ios_outlined,
    ),
  ),
  titleSpacing: 3,
  title: Text(
    title,
  ),
  actions: actions,
);