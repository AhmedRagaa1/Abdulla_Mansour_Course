

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/cubit.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/states.dart';
import 'package:flutter_app/models/Shop_App/Categories_Model.dart';
import 'package:flutter_app/models/Shop_App/home_model.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit ,ShopStates>(
      listener: (context , state)
      {
        if(state is ShopSuccessChangeFavortiesState)
          {
            if(!state.model.status)
            {
              Fluttertoast.showToast(
                  msg: state.model.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
      },
      builder: (context , state)
    {
      return ConditionalBuilder
        (
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).cateogriesModel != null ,
          builder:(context)=> ProductsBulider(ShopCubit.get(context).homeModel , ShopCubit.get(context).cateogriesModel , context),
          fallback:(context) => Center(child: CircularProgressIndicator()),
      );
    },
    );
  }
  Widget ProductsBulider(HomeModel model, CategoriesModel categoriesModel , context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
         CarouselSlider(
             items:model.data.banners.map((e) => Image(
               image: NetworkImage('${e.image}'),
               width: double.infinity,
               fit: BoxFit.cover,
             )).toList(),
             options: CarouselOptions(
               height: 250,
               initialPage: 0,
               viewportFraction: 1,
               enableInfiniteScroll: true,
               reverse: false,
               autoPlay: true,
               autoPlayInterval: Duration(seconds: 3),
               autoPlayAnimationDuration: Duration(seconds: 1),
               autoPlayCurve: Curves.fastOutSlowIn,
               scrollDirection: Axis.horizontal,
             ),
         ),
         SizedBox(
           height: 10,
         ),
         Padding(
           padding: const EdgeInsets.symmetric(
               horizontal: 10,
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 'Categories',
                 style: TextStyle(
                   fontSize: 24,
                   fontWeight: FontWeight.w800,
                 ),
               ),
               SizedBox(
                 height: 10,
               ),
               Container(
                 height: 100,
                 child: ListView.separated(
                   physics: BouncingScrollPhysics(),
                   scrollDirection: Axis.horizontal,
                     itemBuilder: (context , index) => buildCategoryItem(categoriesModel.data.data[index]),
                     separatorBuilder: (context , index) => SizedBox(
                       width: 10,
                     ) ,
                     itemCount: categoriesModel.data.data.length,
                 ),
               ),
               SizedBox(
                 height: 20,
               ),
               Text(
        'New Products',
        style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
        ),
      ),
             ],
           ),
         ),
         Container(
           color: Colors.grey[300],
           child: GridView.count(
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               crossAxisCount: 2,
               mainAxisSpacing: 1,
               crossAxisSpacing: 1,
               childAspectRatio: 1 / 1.68,
               children:
               List.generate(
                 model.data.products.length,
                     (index) => buildGridProduct(model.data.products[index] , context),
               ),


           ),
         ),
    ],
  ),
      );

  Widget buildCategoryItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(
        image: NetworkImage(model.image),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 100,
        child: Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct(ProductsModel model , context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:
      [
          Image(
            image: NetworkImage(model.image),
            width: double.infinity,
            height: 190,
          ),
        if(model.discount != 0)
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
         Padding(
           padding: const EdgeInsets.all(12.0),
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
               Row(
                 children: [
                   Text(
                     '${model.price.round()}',
                     style: TextStyle(
                       fontSize: 12,
                       color: defaultColor,
                     ),
                   ),
                   SizedBox(
                     width: 5,
                   ),
                   if(model.discount != 0)
                   Text(
                     '${model.oldPrice.round()}',
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
                        print(model.id);
                      },
                       icon: CircleAvatar(
                         radius: 15,
                         backgroundColor: ShopCubit.get(context).favorites[model.id] ? defaultColor : Colors.grey,
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
  );
}