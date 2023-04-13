import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../models/favorites_model.dart';

class ShopCubit extends Cubit <ShopStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List <Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map <int, bool> favorites = {};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element)
      {
        favorites.addAll({
          element.id! : element.inFavorites!,
        });
      });
      if (kDebugMode)
      {
        print(homeModel?.data?.banners[0].image);
        print(homeModel?.status);
        print(favorites.toString());
      }
      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories()
  {
    DioHelper.getData(
        url: GET_CATEGORIES,
        token: token).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id' : productId,
      },
      token: token,
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (kDebugMode)
      {
        print(value.data);
      }

      if(!changeFavoritesModel!.status)
      {
        favorites[productId] = !favorites[productId]!;
      }
      else
        {
          getFavorites();
        }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error)
    {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
        url: FAVORITES,
        token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      if (kDebugMode) {
        printFullText(value.data.toString());
      }
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(ShopErrorGetFavoritesState());
    });
  }

  LoginModel? userModel;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel = LoginModel.fromJson(value.data);
      if (kDebugMode) {
        print(userModel!.data!.name);
      }
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(ShopErrorUserDataState());
    });
  }
}