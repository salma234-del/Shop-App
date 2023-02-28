import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    ProductsScreen(),
    FavoritesScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  dynamic homeModel;

  void getHomeData() {
    emit(ShopHomeDataLoadingState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      debugPrint(homeModel.data.banners[0].image);
      emit(ShopHomeDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopHomeDataErrorState());
    });
  }

  dynamic categoryModel;

  void getCategoryData() {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoryModel = CategoriesModel.fromJson(value.data);
        debugPrint(categoryModel.data.data[0].image);
      emit(ShopCategoriesDataSuccessState());
    }).catchError((error) {
      debugPrint('Cat error${error.toString()}');
      emit(ShopCategoriesDataErrorState());
    });
  }
}
