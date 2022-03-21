import 'package:flutter_app/models/Shop_App/Change_Favorites_Model.dart';
import 'package:flutter_app/models/Shop_App/login_model.dart';

abstract  class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeState extends ShopStates{}

class ShopSuccessHomeState extends ShopStates{}

class ShopErrorHomeState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopSuccessChangeFavortiesState extends ShopStates
{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavortiesState(this.model);
}

class ShopChangeFavortiesState extends ShopStates{}

class ShopErrorChangeFavortesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopLoadingUserDataState extends ShopStates{}

class ShopErrorUserDataState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopLoadingUpdateUserState extends ShopStates{}

class ShopErrorUpdateUserState extends ShopStates{}