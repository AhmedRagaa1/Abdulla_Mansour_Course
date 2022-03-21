import 'package:flutter/material.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/cubit.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/states.dart';
import 'package:flutter_app/models/Shop_App/Categories_Model.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CateogriesScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return ListView.separated
          (
          itemBuilder: (context , index) => buildCatItem(ShopCubit.get(context).cateogriesModel.data.data[index]),
          separatorBuilder: (context , index) => myDivider(),
          itemCount: ShopCubit.get(context).cateogriesModel.data.data.length,
        );
      },

    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(
          image: NetworkImage(model.image),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          model.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
            Icons.arrow_forward_ios
        ),

      ],
    ),
  );
}