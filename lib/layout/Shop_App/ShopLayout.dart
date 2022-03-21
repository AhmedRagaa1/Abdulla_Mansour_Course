import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Shop__App/search/Search.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/cubit.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/states.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Salla',
            ),
            actions:
            [
              IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: ()
                  {
                    NavigateTo(context, SearchShop());
                  },
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar
            (
            onTap: (index)
            {
              cubit.ChangeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items:
            [
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.apps,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.favorite,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),

        );
      },

    );
  }
}
