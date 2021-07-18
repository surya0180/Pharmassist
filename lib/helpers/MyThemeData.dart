import 'package:flutter/material.dart';

final MyThemeData = ThemeData(
  primaryColor: Colors.blue[300],
  primarySwatch: Colors.blue,
  accentColor: Colors.greenAccent[100],
  canvasColor: Colors.blue[50],
  backgroundColor: Colors.white,
  cardColor: Colors.amber[50],
  fontFamily: 'Poppins',
  textTheme: ThemeData.light().textTheme.copyWith(
        body1: TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1),
        ),
        body2: TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1),
        ),
        title: TextStyle(
          fontSize: 18,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue[200],
    titleTextStyle: TextStyle(color: Colors.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.black,
    elevation: 10,
  ),
);
