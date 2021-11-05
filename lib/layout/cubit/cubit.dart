import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_models.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/shared/componets/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialStats());

  static ShopCubit get(context) => BlocProvider.of(context);

  bool isLast = false;

  void changePage(int index) {
    if (index == 2) {
      isLast = true;
    } else {
      isLast = false;
      print('isLast 1');
    }
    emit(ChangePageBoarding());
  }

  int currantIndex = 0;

  List changeBottom = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void changeBottomScreen(int index) {
    currantIndex = index;
    emit(ChangeBottomScreen());
  }

  ChangeFavoritesModel? changeFavoritesModel;

  HomeModel? homeModel;

  FavoritesModel? favoritesModel;

  CategoriesModel? categoriesModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeStates());
    DioHelper.getData(url: Home, token: token).then((value) {
      homeModel = HomeModel.formHome(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.in_favorites!});
      });
      print('vvvvvvvvvvvvvvvvv ${favorites.toString()}');
      emit(ShopSuccessHomeStates());
    }).catchError((error) {
      print('the error must <<< ${error.toString()} >>>');
      emit(ShopErrorHomeStates());
    });
  }

  void getCategoriesData() {
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print('the error must <<< ${error.toString()} >>>');
      emit(ShopErrorCategoriesStates());
    });
  }

  void changeFavorite(int id) {
    favorites[id] = !favorites[id]!;
    emit(ShopFavoritesSuccessStates());

    DioHelper.postData(
            url: FAVORITES,
            data: {
              'product_id': id,
            },
            token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.formJson(value.data);

      if (changeFavoritesModel!.status == false) {
        favorites[id] = !favorites[id]!;
      } else {
        getFavoritesData();
      }
      print(changeFavoritesModel!.message);
      emit(ShopChaneFavoritesSuccessStates());
    }).catchError((error) {
      favorites[id] = !favorites[id]!;
      emit(ShopChaneFavoritesErrorStates());
    });
  }

  void getFavoritesData() {
    emit(ShopChaneFavoritesLoadingStates());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.formJson(value.data);
      print(favoritesModel!.data!.data[1].product!.name);
      emit(ShopSuccessFavoritesStates());
    }).catchError((error) {
      print('the error must <<< ${error.toString()} >>>');
      emit(ShopErrorFavoritesStates());
    });
  }

  ShopLoginModel? userModelData;

  void getUserData() {
    emit(ShopLoadingUserStates());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModelData = ShopLoginModel.formJson(value.data);
      emit(ShopSuccessUserStates());
    }).catchError((error) {
      print('the error must <<< ${error.toString()} >>>');
      emit(ShopErrorUserStates());
    });
  }

  void getUpdateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateProfileStates());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: token,
    ).then((value) {
      userModelData = ShopLoginModel.formJson(value.data);
      emit(ShopSuccessUpdateProfileStates());
    }).catchError((error) {
      print('the error must <<< ${error.toString()} >>>');
      emit(ShopErrorUpdateProfileStates());
    });
  }

  SearchModel? searchModel;

  void search(String text) {
    emit(ShopSearchLoadingStates());

    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.formJson(value.data);
      print(searchModel!.data!.data[1].name);
      emit(ShopSearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorStates());
    });
  }
}
