import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
   return Scaffold(
     appBar: AppBar(
       actions: [
         IconButton(icon:Icon(
           Icons.notification_important,
         ),
             onPressed:onNotfication,
         ),
         IconButton(icon: Icon(
           Icons.search,
         ),
             onPressed: ()
             {
               print("Hello");
             }
         )
       ],
       title: Text(
         "First App",
       ),
       leading: IconButton(
         icon: Icon(
           Icons.menu,
         ),
         onPressed: ()
         {
           "Menu";
         },
       ),
       shadowColor:Colors.purpleAccent ,
       backgroundColor: Colors.purple,
       centerTitle: true,
     ),
     body: SingleChildScrollView(
       scrollDirection: Axis.vertical,    //الطبيعه راسي ولكن لو في صفوف ممكن نغيرها الي افقي
       child: Container(
         width: double.infinity,
         color: Colors.indigo,
         child: Column(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.center,
             children:
             [
               Padding(
                   padding: const EdgeInsets.all(20),
                   child: Container(
                     width: 300,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(50),
                     ),
                     clipBehavior: Clip.antiAliasWithSaveLayer,
                     child: Stack(
                       alignment: Alignment.bottomCenter,
                       children: [
                         Image(image:NetworkImage
                           (
                           "https://vogtsflowers.imgix.net/images/homepageFeatureArea/Celebration-Bouquet-mobile-background-image-21060730107.jpg?auto=format&w=410&h=250&fit=crop",

                         ),
                           height: 300,
                           width: 300,
                           fit: BoxFit.cover,
                         ),
                         Container(
                           color: Colors.black.withOpacity(.7),
                           width: double.infinity,
                           padding: EdgeInsets.symmetric(
                             vertical: 10,
                           ),
                           child: Text
                             (
                             "Flowers",
                             textAlign: TextAlign.center,
                             style: TextStyle
                               (
                               fontSize: 20,
                               color: Colors.white,

                             ),

                           ),
                         ),
                       ],
                     ),
                   ),
                 ),

               Container(
                 height: 60,
                 child: Text(
                   "Hello in my App",
                   style: TextStyle
                     (
                       color:Colors.purpleAccent,
                       fontSize: 40,

                     ),
                 ),
               ),
               Container(
                 child: Text(
                   "How are you ?",
                   style: TextStyle
                     (
                       fontSize: 30,
                       color: Colors.purpleAccent,
                     ),
                 ),
               ),
               Container(
                 child: Text(
                   "How are you ?",
                   style: TextStyle
                     (
                     fontSize: 30,
                     color: Colors.purpleAccent,
                   ),
                 ),
               ),


             ],
           ),
       ),
     ),
     );
     

  }
  void onNotfication(){
    print("Notfication clicked");
  }
}
