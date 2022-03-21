import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Shop__App/cateogries/Cateogries.dart';
import 'package:flutter_app/Modules/Shop__App/favorites/favorites.dart';
import 'package:flutter_app/Modules/Shop__App/products/Products.dart';
import 'package:flutter_app/Modules/Shop__App/setting/SettingScreen.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/states.dart';
import 'package:flutter_app/models/Shop_App/Favorites_model.dart';
import 'package:flutter_app/models/Shop_App/Categories_Model.dart';
import 'package:flutter_app/models/Shop_App/Change_Favorites_Model.dart';
import 'package:flutter_app/models/Shop_App/home_model.dart';
import 'package:flutter_app/models/Shop_App/login_model.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_app/shared/network/end_points.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen =
  [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  void ChangeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;

  Map<int , bool> favorites = {};

  void getHomeData()
  {
    emit(ShopLoadingHomeState());

    DioHelper.getData
      (
        url: HOME,
        token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

      // printFullText(homeModel.data.banners[0].image);
      // print(homeModel.status);

      homeModel.data.products.forEach((element)
      {
        favorites.addAll({
          element.id : element.inFavorites,
        });
        print(favorites.toString());

      });

      emit(ShopSuccessHomeState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeState());
    });

    
  }

  CategoriesModel cateogriesModel;

  void getCateogries()
  {

    DioHelper.getData
      (
      url: GET_CATEGORIES,
      token: token,
    ).then((value)
    {
      cateogriesModel = CategoriesModel.fromjson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });


  }



  ChangeFavoritesModel changeFavoritesModel;

  void ChangeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavortiesState());

    DioHelper.postData(
        url: FAVORITES,
        data:
        {
          'product_id' : productId,
        },
      token: token,
    ).then((value)  {
      changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data);
      print(value.data);


      if(!changeFavoritesModel.status)
      {
        favorites[productId] = !favorites[productId];
      }else
        {
          getFavorites();
        }


      emit(ShopSuccessChangeFavortiesState(changeFavoritesModel));
    }).catchError((error){

      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavortesState());
    });
  }


  FavoritesModel favoritesModel;

  void getFavorites()
  {

    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData
      (
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });


  }

  ShopLoginModel usermodel;

  void getUserData()
  {

    emit(ShopLoadingUserDataState());

    DioHelper.getData
      (
      url: PROFILE,
      token: token,
    ).then((value)
    {
      usermodel = ShopLoginModel.fromjson(value.data);
      printFullText(usermodel.data.name);

      emit(ShopSuccessUserDataState(usermodel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });


  }

  void UpdateUserData({
  @required String name,
  @required String email,
  @required String phone,
})
  {

    emit(ShopLoadingUpdateUserState());

    DioHelper.putData
      (
      url: UPDATEPROFILE,
      token: token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value)
    {
      usermodel = ShopLoginModel.fromjson(value.data);
      printFullText(usermodel.data.name);

      emit(ShopSuccessUpdateUserState(usermodel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });


  }
}
