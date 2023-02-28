import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/componants.dart';
import '../components/constants.dart';

ThemeData light = ThemeData(
  fontFamily: 'Open_Sans',
  primarySwatch: buildMaterialColor(defaultColor),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xffe56b6f),
    unselectedItemColor: Colors.black,
    elevation: 30,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
);
