import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/cubit.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/states.dart';
import 'package:flutter_app/models/Shop_App/Favorites_model.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return ConditionalBuilder(
          condition: state is ! ShopLoadingGetFavoritesState,
          builder:(context) => ListView.separated
            (
            itemBuilder: (context , index) => buildListProduct(ShopCubit.get(context).favoritesModel.data.data[index].product , context),
            separatorBuilder: (context , index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

}