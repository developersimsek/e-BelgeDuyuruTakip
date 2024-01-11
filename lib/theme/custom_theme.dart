import 'package:flutter/material.dart';
import 'style_element.dart';

class CustomTheme {
  ThemeData themeData = ThemeData(
    useMaterial3: true,
    appBarTheme: _AppBar().appBarTheme,
    tabBarTheme: _TabBar().tabBarTheme,
    inputDecorationTheme: _InputDecorationTheme().inputDecorationTheme,
    elevatedButtonTheme: _ElevatedButtonThemeData().elevatedButtonThemeData,
    scaffoldBackgroundColor: AppColorItem().white70,
  );
}

class _AppBar {
  AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: AppColorItem().lightBlue,
    titleTextStyle: _Text().textStyle,
    actionsIconTheme:
        IconThemeData(color: AppColorItem().white, size: AppSizeItem().size30),
    iconTheme: IconThemeData(color: AppColorItem().white),
  );
}

class _TabBar {
  TabBarTheme tabBarTheme = TabBarTheme(
      labelColor: AppColorItem().white,
      unselectedLabelColor: AppColorItem().white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: AppColorItem().white);
}

class _Text {
  TextStyle textStyle = TextStyle(
    color: AppColorItem().white,
    fontSize: AppSizeItem().size20,
  );
}

class _InputDecorationTheme {
  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    labelStyle: TextStyle(color: AppColorItem().white70),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: AppColorItem().white,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide:
          BorderSide(style: BorderStyle.solid, color: AppColorItem().black),
    ),
  );
}

class _ElevatedButtonThemeData {
  ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        foregroundColor: AppColorItem().lightBlue,
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: AppSizeItem().size05,
            fontSize: AppSizeItem().size15)),
  );
}
