import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/style.dart';

ThemeData themeLite = ThemeData(
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600)),
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: Colors.white,
      elevation: 0.0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: colors,
        type: BottomNavigationBarType.fixed,
        elevation: 20.0));

ThemeData themeDark = ThemeData(
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600)),
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(
        color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: colorAll,
    unselectedItemColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
);
