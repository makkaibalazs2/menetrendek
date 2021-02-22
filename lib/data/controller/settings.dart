import 'package:flutter/material.dart';
import 'package:menetrend/helpers/theme.dart';

class SettingsController {
  ThemeData theme;
  ThemeSetting themetype = ThemeSetting.light;

  // TODO: separate themecontroller, we shouldnt declare themes here.
  SettingsController() {
    theme = Themes.light;
  }
}

class Themes {
  static Color lightTextColor = Colors.grey[700];
  static TextTheme lightText = TextTheme(
    headline6: TextStyle(
      fontFamily: "GoogleSans",
      color: lightTextColor,
      fontSize: 20.0,
    ),
    bodyText1: TextStyle(
      fontFamily: "GoogleSans",
      color: lightTextColor,
    ),
    bodyText2: TextStyle(
      fontFamily: "GoogleSans",
      color: lightTextColor,
    ),
  );

  static Color lightBackground = Colors.white;
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    accentColor: Colors.blueAccent,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[100],
    textTheme: lightText,
    primaryTextTheme: lightText,
    iconTheme: IconThemeData(color: lightTextColor),
    fontFamily: "GoogleSans",
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey[200],
      actionTextColor: Colors.blueAccent,
      contentTextStyle: TextStyle(color: lightTextColor),
    ),
    dialogBackgroundColor: lightBackground,
    appBarTheme: AppBarTheme(
        color: Colors.white,
        textTheme: lightText,
        iconTheme: IconThemeData(color: lightTextColor)),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.white),
  );
  static Color darkTextColor = Colors.grey[100];
  static TextTheme darkText = TextTheme(
      headline6: TextStyle(
          fontFamily: "GoogleSans", color: darkTextColor, fontSize: 20.0),
      bodyText1: TextStyle(fontFamily: "GoogleSans", color: darkTextColor),
      bodyText2: TextStyle(fontFamily: "GoogleSans", color: darkTextColor));

  static Color blackBackground = Color(0xff000000);
  static ThemeData dark = ThemeData(
      cardColor: Color(0xff111111),
      brightness: Brightness.dark,
      accentColor: Colors.redAccent[700],
      backgroundColor: blackBackground,
      textTheme: darkText,
      primaryTextTheme: darkText,
      iconTheme: IconThemeData(color: Colors.grey[100]),
      fontFamily: "GoogleSans",
      scaffoldBackgroundColor: blackBackground,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: blackBackground,
        actionTextColor: Colors.redAccent[700],
        contentTextStyle: TextStyle(color: darkTextColor),
      ),
      dialogBackgroundColor: blackBackground,
      appBarTheme:
          AppBarTheme(backgroundColor: blackBackground, textTheme: darkText),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: blackBackground,
      ));
}
