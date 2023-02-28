import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool boarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  Widget widget = ShopLayout();
  //LoginScreen();

  // if (boarding == null)
  //   widget = OnBoardingScreen();
  // else {
  //   if (token == null)
  //     widget = LoginScreen();
  //   else
  //     widget = ShopLayout();
  // }

  //print(boarding);
  runApp(MyApp(boarding, widget));
}

class MyApp extends StatelessWidget {
  final bool boarding;
  final Widget widget;
  const MyApp(this.boarding, this.widget, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategoryData(),
        ),
      ],
      child: MaterialApp(
        theme: light,
        debugShowCheckedModeBanner: false,
        home: widget,
      ),
    );
  }
}
