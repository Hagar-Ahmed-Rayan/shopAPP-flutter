

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/category.dart';
import 'package:untitled2/fav.dart';
import 'package:untitled2/models/categorries.dart';
import 'package:untitled2/models/changefavmodel.dart';
import 'package:untitled2/models/favmodel.dart';
import 'package:untitled2/models/home-model.dart';
import 'package:untitled2/models/login-model.dart';
import 'package:untitled2/modules/login/cubit/shop-layout-states.dart';
import 'package:untitled2/product.dart';
import 'package:untitled2/setting.dart';
import 'package:untitled2/shared/consts.dart';
import 'package:untitled2/shared/network/end-poins.dart';
import 'package:untitled2/shared/network/remote/dio-healper.dart';
/*import 'package:marketapp/categories.dart';
import 'package:marketapp/favourite.dart';
import 'package:marketapp/models/categories.dart';
import 'package:marketapp/models/changefavouritemodel.dart';
import 'package:marketapp/models/favouritemodel.dart';
import 'package:marketapp/models/home-odel.dart';
import 'package:marketapp/modules/login/cubit/shoplayout-state.dart';
import 'package:marketapp/product.dart';
import 'package:marketapp/setting.dart';
import 'package:marketapp/shared/constants.dart';
import 'package:marketapp/shared/network/end-points.dart';
import 'package:marketapp/shared/network/remote/dio-healper.dart'; */

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
  // HomeModel homeModel;
  // HomeModel homeModel=null as HomeModel;
  dynamic homeModel=null;
  Map<int ,bool>favourites={};
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      query: null,
      token: token,
    ).then((value)
    {
      print('uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu');
      homeModel = HomeModel.fromJson(value.data);

      // print(homeModel.data.banners[0].image);
      //    print(homeModel.status);

      homeModel.data.products.forEach((element) {
        favourites.addAll({
          element.id: element.inFavorites,
        });
      });
      print("99999999999999999999999999999999999999999999999999999999999999999999999999999999999999");
      print(favourites.toString());



      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });






  }

  late CategoriesModel categoriesModel;
  //dynamic  categoriesModel=null;

  void getCategories()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }




// late ChangeFavoritesModel changeFavoritesModel;
 dynamic changeFavoritesModel=null;
 // late FavoritesModel favoritesModel;
 // dynamic favoritesModel=null;

  void changeFavorites(int productId)
  {

    favourites[productId] = !favourites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel.status)
      { print("efeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      favourites[productId] = !favourites[productId]!;
      } else
      { print("elseeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      print(error.toString());


      emit(ShopErrorChangeFavoritesState());
    });
  }

 // dynamic favoritesModel;
   dynamic favoritesModel;

 // dynamic favoritesModel=null;
  void getFavorites()
  {


    print("ef77777777777777777777777777777777777777777777777777777");
   //  print(favoritesModel.data.data.length);
  emit(ShopLoadingGetFavoritesState());
//FAVORITES
  DioHelper.getData(url:FAVORITES,

      token: token)
      .then((value)
  {
    favoritesModel = FavoritesModel.fromJson(value.data);
   // print(value.data.toString());
  //  print(value.data.length());
    print(favoritesModel.data.data.length);

    print("ef55555555555555555555555555555555555555555555555555555555555555555555555555555");
    emit(ShopSuccessGetFavoritesState());
  }).catchError((error) {
    print(error.toString());
    print(favoritesModel.data.data.length );

    emit(ShopErrorGetFavoritesState());
  });
  }



//  ShopLoginModel userModel=null as ShopLoginModel;


  dynamic userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
     print ("سبحااااااااااااان الله ");
      print(userModel.data.name);
      print("اااااااااااااااااااااااااااااااااااااااااااااااااااالحمد لله");

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      print("يلهويييييييييييييييييييييييييييييييي");
      emit(ShopErrorUserDataState());
    });
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.data.name);

      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }












}














